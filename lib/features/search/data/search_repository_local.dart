import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_pokedex/local_db/app_local_database.dart' as db;
import 'package:flutter_pokedex/features/search/domain/pokemon_model.dart';
import 'dart:convert';

part 'search_repository_local.g.dart';

class PokemonsRepositoryLocal {
  final db.AppDatabase _db;

  PokemonsRepositoryLocal(this._db);

  Future<void> saveSearchResults(String query, List<Pokemon> results) async {
    final jsonResults = results.map((pokemon) => pokemon.toJson()).toList();
    final cache = db.SearchCachesCompanion.insert(
      query: query,
      result: jsonEncode(jsonResults),
      timestamp: DateTime.now(),
    );
    await _db.addSearchCache(cache);
  }

  Future<List<Pokemon>?> getCachedSearchResults(String query) async {
    final cache = await _db.getCacheByQuery(query);
    if (cache != null) {
      final List<dynamic> jsonResults = jsonDecode(cache.result);
      return jsonResults.map((json) => Pokemon.fromJson(json)).toList();
    }
    return null;
  }

  Future<void> saveRandomPokemonList(List<Pokemon> pokemons) async {
    await saveSearchResults('random_list', pokemons);
  }

  Future<List<Pokemon>?> getCachedRandomPokemonList() async {
    return await getCachedSearchResults('random_list');
  }
}

@riverpod
PokemonsRepositoryLocal pokemonsRepositoryLocal(
    PokemonsRepositoryLocalRef ref) {
  final database = ref.watch(db.appDatabaseProvider);
  return PokemonsRepositoryLocal(database);
}
