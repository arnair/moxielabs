import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/pokemon_model.dart';
import '../application/search_service.dart';
import '../data/search_repository_local.dart';
import 'package:flutter_pokedex/features/authentication/domain/user_model.dart';

part 'search_controller.g.dart';

@Riverpod(keepAlive: true)
class SearchController extends _$SearchController {
  late final SearchService _service;
  late final PokemonsRepositoryLocal _localRepository;
  late final User _currentUser;

  @override
  List<Pokemon> build(User user) {
    _service = ref.watch(searchServiceProvider);
    _localRepository = ref.watch(pokemonsRepositoryLocalProvider);
    _currentUser = user;
    return [];
  }

  Future<bool> searchPokemon(String name) async {
    try {
      final pokemon = await _service.searchPokemonByName(name);
      if (pokemon != null) {
        state = [pokemon];
        return true;
      }
      return false;
    } catch (e) {
      // Don't update state on error, keep current list
      return false;
    }
  }

  Future<void> getRandomPokemon() async {
    try {
      final randomPokemon = await _service.getRandomPokemons();
      state = randomPokemon;
      // Save the random pokemon list for the current user
      await _localRepository.saveSurprisePokemonList(
          randomPokemon, _currentUser.id);
    } catch (e) {
      state = [];
    }
  }

  void updatePokemonState(Pokemon updatedPokemon) {
    // Create a new list with the updated Pokémon
    state = [
      for (final pokemon in state)
        pokemon.id == updatedPokemon.id ? updatedPokemon : pokemon
    ];
  }

  Stream<List<Pokemon>> watchSurprisePokemonList() {
    return _localRepository.watchSurprisePokemonList(_currentUser.id);
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
