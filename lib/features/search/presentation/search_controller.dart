import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/pokemon_model.dart';
import '../application/search_service.dart';

part 'search_controller.g.dart';

@riverpod
class SearchController extends _$SearchController {
  late final SearchService _service;
  final List<Pokemon> _capturedPokemon = [];

  @override
  List<Pokemon> build() {
    _service = ref.watch(searchServiceProvider);
    return [];
  }

  Future<void> searchPokemon(String name) async {
    try {
      final pokemon = await _service.searchPokemonByName(name);
      state = pokemon != null ? [pokemon] : [];
    } catch (e) {
      state = [];
    }
  }

  Future<void> getRandomPokemon() async {
    try {
      final randomPokemon = await _service.getRandomPokemons();
      state = randomPokemon;
    } catch (e) {
      state = [];
    }
  }

  void addToPokedex(Pokemon pokemon) {
    final updatedPokemon = pokemon.copyWith(captured: true);
    final currentList = [...state];
    final index = currentList.indexWhere((p) => p.id == pokemon.id);

    if (index != -1) {
      currentList[index] = updatedPokemon;
      state = currentList;
    }
    if (!_capturedPokemon.any((p) => p.id == pokemon.id)) {
      _capturedPokemon.add(updatedPokemon);
    }
  }

  void removeFromPokedex(Pokemon pokemon) {
    final updatedPokemon = pokemon.copyWith(captured: false);
    final currentList = [...state];
    final index = currentList.indexWhere((p) => p.id == pokemon.id);

    if (index != -1) {
      currentList[index] = updatedPokemon;
      state = currentList;
    }
    _capturedPokemon.removeWhere((p) => p.id == pokemon.id);
  }

  void reorderPokemon(List<Pokemon> newOrder) {
    _capturedPokemon.clear();
    _capturedPokemon.addAll(newOrder);
    state = [...state]; // Trigger rebuild
  }

  List<Pokemon> getCapturedPokemon() {
    return _capturedPokemon;
  }
}

List<Pokemon> filterPokemonList({
  required List<Pokemon> pokemonList,
  required String searchText,
  required bool showCaptured,
  required SearchController controller,
}) {
  if (!showCaptured && searchText.isEmpty) {
    return pokemonList;
  }

  if (!showCaptured) {
    if (searchText.isNotEmpty) {
      return pokemonList
          .where((pokemon) =>
              pokemon.name.toLowerCase().startsWith(searchText.toLowerCase()))
          .toList();
    }
    return pokemonList;
  } else {
    return controller.getCapturedPokemon();
  }
}
