import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_pokedex/features/my_pokedex/data/pokedex_repository_local.dart';
import 'package:flutter_pokedex/features/search/domain/pokemon_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'pokedex_service.g.dart';

class PokedexService {
  final PokedexRepositoryLocal _repository;

  PokedexService(this._repository);

  Stream<List<Pokemon>> watchCapturedPokemon(int userId) {
    return _repository.watchCapturedPokemon(userId);
  }

  Future<void> addPokemonToPokedex(Pokemon pokemon, int userId) async {
    await _repository.setPokemonCaptured(pokemon.id, userId, true,
        pokemon: pokemon);
  }

  Future<void> removePokemonFromPokedex(Pokemon pokemon, int userId) async {
    await _repository.setPokemonCaptured(pokemon.id, userId, false);
  }

  Future<void> reorderPokemon(List<Pokemon> pokemonList, int userId) async {
    for (var i = 0; i < pokemonList.length; i++) {
      await _repository.updatePokemonOrder(pokemonList[i].id, userId, i);
    }
  }
}

@riverpod
PokedexService pokedexService(Ref ref) {
  final repository = ref.watch(pokedexRepositoryLocalProvider);
  return PokedexService(repository);
}
