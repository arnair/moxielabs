import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_pokedex/local_db/app_local_database.dart' as db;
import 'package:flutter_pokedex/features/search/domain/pokemon_model.dart';
import 'package:flutter_pokedex/features/search/domain/pokemon_types_enum.dart';
import 'package:flutter_pokedex/features/search/domain/ability_model.dart';
import 'dart:convert';

part 'pokedex_repository_local.g.dart';

class PokedexRepositoryLocal {
  final db.AppDatabase _db;

  PokedexRepositoryLocal(this._db);

  Stream<List<Pokemon>> watchCapturedPokemon(int userId) {
    return _db.watchCapturedPokemons(userId).map((pokemonDataList) {
      return pokemonDataList.map((data) {
        final effectEntries = jsonDecode(data.effectEntries) as List<dynamic>;
        return Pokemon(
          id: data.id,
          name: data.name,
          imageUrl: data.imageUrl,
          type: (jsonDecode(data.types) as List<dynamic>)
              .map((t) => PokemonTypes.fromString(t))
              .toList(),
          captured: data.captured,
          abilities: effectEntries
              .map((effect) => Ability(
                    id: data.id,
                    abilityName: data.name,
                    generation: data.generation,
                    shortEffect: effect.toString(),
                  ))
              .toList(),
        );
      }).toList();
    });
  }

  Future<void> setPokemonCaptured(int pokemonId, int userId, bool captured,
      {Pokemon? pokemon}) async {
    // First try to update the existing Pokemon
    final result = await _db.setPokemonCaptured(pokemonId, userId, captured);

    // If no rows were affected and we're capturing a Pokemon, insert it
    if (result == 0 && captured && pokemon != null) {
      await _db.insertPokemon(db.PokemonData(
        id: pokemon.id,
        name: pokemon.name,
        imageUrl: pokemon.imageUrl,
        types: jsonEncode(pokemon.type.map((t) => t.name).toList()),
        captured: true,
        generation: pokemon.abilities.isNotEmpty
            ? pokemon.abilities.first.generation
            : 'Unknown',
        effectEntries:
            jsonEncode(pokemon.abilities.map((a) => a.shortEffect).toList()),
        userId: userId,
      ));
    }
  }

  Future<void> updatePokemonOrder(int pokemonId, int userId, int order) async {
    await _db.updatePokemonOrder(pokemonId, userId, order);
  }
}

@riverpod
PokedexRepositoryLocal pokedexRepositoryLocal(PokedexRepositoryLocalRef ref) {
  final database = ref.watch(db.appDatabaseProvider);
  return PokedexRepositoryLocal(database);
}
