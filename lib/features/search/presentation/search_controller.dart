import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/pokemon_model.dart';
import '../application/search_service.dart';
import '../data/search_repository_local.dart';
import 'package:flutter_pokedex/features/authentication/domain/user_model.dart';

part 'search_controller.g.dart';

class SearchState {
  final List<Pokemon> pokemons;
  final bool isLoading;
  final String? error;

  const SearchState({
    this.pokemons = const [],
    this.isLoading = false,
    this.error,
  });

  SearchState copyWith({
    List<Pokemon>? pokemons,
    bool? isLoading,
    String? error,
  }) {
    return SearchState(
      pokemons: pokemons ?? this.pokemons,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

@Riverpod(keepAlive: true)
class SearchController extends _$SearchController {
  late final SearchService _service;
  late final PokemonsRepositoryLocal _localRepository;
  late final User _currentUser;

  @override
  SearchState build(User user) {
    _service = ref.watch(searchServiceProvider);
    _localRepository = ref.watch(pokemonsRepositoryLocalProvider);
    _currentUser = user;
    return const SearchState();
  }

  Future<bool> searchPokemon(String name) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final pokemon = await _service.searchPokemonByName(name);
      if (pokemon != null) {
        state = state.copyWith(
          pokemons: [pokemon],
          isLoading: false,
        );
        return true;
      }
      state = state.copyWith(isLoading: false);
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<void> getRandomPokemon() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final randomPokemon = await _service.getRandomPokemons();
      state = state.copyWith(
        pokemons: randomPokemon,
        isLoading: false,
      );
      // Save the random pokemon list for the current user
      await _localRepository.saveSurprisePokemonList(
          randomPokemon, _currentUser.id);
    } catch (e) {
      state = state.copyWith(
        pokemons: [],
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Stream<List<Pokemon>> watchSurprisePokemonList() {
    return _localRepository.watchSurprisePokemonList(_currentUser.id);
  }

  void updatePokemonState(Pokemon updatedPokemon) {
    state = state.copyWith(
      pokemons: [
        for (final pokemon in state.pokemons)
          pokemon.id == updatedPokemon.id ? updatedPokemon : pokemon
      ],
    );
  }

  void updatePokemonsList(List<Pokemon> pokemons) {
    state = state.copyWith(pokemons: pokemons);
  }
}

List<Pokemon> filterPokemonList({
  required List<Pokemon> pokemonList,
  required String searchText,
}) {
  if (searchText.isEmpty) {
    return pokemonList;
  }

  return pokemonList
      .where((pokemon) =>
          pokemon.name.toLowerCase().startsWith(searchText.toLowerCase()))
      .toList();
}
