import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        return Pokemon(
          id: data.id,
          name: data.name,
          imageUrl: data.imageUrl,
          type: (jsonDecode(data.types) as List<dynamic>)
              .map((t) => PokemonTypes.fromString(t))
              .toList(),
          captured: data.captured,
          abilities: (jsonDecode(data.effectEntries) as List<dynamic>)
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
    await _db.setPokemonCaptured(pokemonId, userId, captured);

    // If we're capturing a Pokemon and it doesn't exist, insert it
    if (captured && pokemon != null) {
      // Check if the Pokemon exists in the database
      final existingPokemon = await _db
          .watchCapturedPokemons(userId)
          .map((list) => list.any((p) => p.id == pokemonId))
          .first;

      if (!existingPokemon) {
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
  }

  Future<void> updatePokemonOrder(int pokemonId, int userId, int order) async {
    await _db.updatePokemonOrder(pokemonId, userId, order);
  }
}

@riverpod
PokedexRepositoryLocal pokedexRepositoryLocal(Ref ref) {
  final database = ref.watch(db.appDatabaseProvider);
  return PokedexRepositoryLocal(database);
}
