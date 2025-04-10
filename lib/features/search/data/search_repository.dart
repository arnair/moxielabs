import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/constants/paths.dart';
import 'package:flutter_pokedex/features/search/domain/pokemon_model.dart';
import 'package:flutter_pokedex/features/search/domain/ability_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'search_repository.g.dart';

class SearchRepository {
  final Dio _dio = Dio();
  final Map<int, Ability> _abilityCache = {};

  Future<(Pokemon?, List<int>)> searchPokemon(String name) async {
    try {
      final response = await _dio.get(
        '${Paths.pokemonApiBaseUrl}${name.toLowerCase()}',
      );

      if (response.statusCode == 404) {
        return (null, <int>[]);
      }

      if (response.statusCode != 200) {
        throw Exception('Failed to load Pokemon data: ${response.statusCode}');
      }

      final pokemon = Pokemon.pokemonApiJson(response.data);
      final abilityIds = Pokemon.extractAbilityIds(response.data);
      return (pokemon, abilityIds);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw Exception('No internet connection');
      }
      throw Exception('Failed to load Pokemon data: ${e.message}');
    }
  }

  Future<Ability?> searchAbility(int id) async {
    // Return cached ability if available
    if (_abilityCache.containsKey(id)) {
      return _abilityCache[id];
    }

    try {
      final response = await _dio.get(
        '${Paths.abilityApiBaseUrl}$id',
      );

      if (response.statusCode == 404) {
        return null;
      }

      if (response.statusCode != 200) {
        throw Exception('Failed to load Ability data: ${response.statusCode}');
      }

      final ability = Ability.fromApiJson(response.data);
      _abilityCache[id] = ability; // Cache the ability
      return ability;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw Exception('No internet connection');
      }
      throw Exception('Failed to load Ability data: ${e.message}');
    }
  }
}

@riverpod
SearchRepository pokemonsRepository(Ref ref) {
  return SearchRepository();
}
