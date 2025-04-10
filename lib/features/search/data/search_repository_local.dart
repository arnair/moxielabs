import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_pokedex/local_db/app_local_database.dart' as db;
import 'package:flutter_pokedex/features/search/domain/pokemon_model.dart';
import 'package:flutter_pokedex/features/search/domain/pokemon_types_enum.dart';
import 'dart:convert';

part 'search_repository_local.g.dart';

class PokemonsRepositoryLocal {
  final db.AppDatabase _db;

  PokemonsRepositoryLocal(this._db);

  Future<void> saveSurprisePokemonList(
      List<Pokemon> pokemons, int userId) async {
    final pokemonDataList = pokemons
        .map((pokemon) => db.PokemonData(
              id: pokemon.id,
              name: pokemon.name,
              imageUrl: pokemon.imageUrl,
              types: jsonEncode(pokemon.type.map((t) => t.toString()).toList()),
              captured: pokemon.captured,
              generation: pokemon.abilities.isNotEmpty
                  ? pokemon.abilities.first.generation
                  : 'unknown',
              effectEntries: jsonEncode(pokemon.abilities
                  .map((ability) => ability.shortEffect)
                  .toList()),
              userId: userId,
            ))
        .toList();

    await _db.replaceSurprisePokemons(pokemonDataList, userId);
  }

  Stream<List<Pokemon>> watchSurprisePokemonList(int userId) {
    return _db.watchSurprisePokemons(userId).map((pokemonDataList) {
      return pokemonDataList
          .map((data) => Pokemon(
                id: data.id,
                name: data.name,
                imageUrl: data.imageUrl,
                type: (jsonDecode(data.types) as List<dynamic>)
                    .map((t) => PokemonTypes.fromString(t))
                    .toList(),
                captured: data.captured,
                abilities: [], // We don't store full ability objects locally
              ))
          .toList();
    });
  }

  Stream<List<Pokemon>> watchCapturedPokemons(int userId) {
    return _db.watchCapturedPokemons(userId).map((pokemonDataList) {
      return pokemonDataList
          .map((data) => Pokemon(
                id: data.id,
                name: data.name,
                imageUrl: data.imageUrl,
                type: (jsonDecode(data.types) as List<dynamic>)
                    .map((t) => PokemonTypes.fromString(t))
                    .toList(),
                captured: data.captured,
                abilities: [], // We don't store full ability objects locally
              ))
          .toList();
    });
  }

  Future<void> setPokemonCaptured(
      int pokemonId, int userId, bool captured) async {
    await _db.setPokemonCaptured(pokemonId, userId, captured);
  }

  Future<void> updatePokemonOrder(int pokemonId, int userId, int order) async {
    await _db.updatePokemonOrder(pokemonId, userId, order);
  }
}

@riverpod
PokemonsRepositoryLocal pokemonsRepositoryLocal(
    PokemonsRepositoryLocalRef ref) {
  final database = ref.watch(db.appDatabaseProvider);
  return PokemonsRepositoryLocal(database);
}
