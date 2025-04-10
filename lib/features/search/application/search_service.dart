import 'package:flutter_pokedex/features/search/domain/ability_model.dart';
import 'package:flutter_pokedex/features/search/domain/pokemon_model.dart';
import 'package:flutter_pokedex/features/search/data/search_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:math';

part 'search_service.g.dart';

class SearchService {
  final SearchRepository _repository;
  final Random _random = Random();

  SearchService(this._repository);

  Future<List<Pokemon>> getRandomPokemons() async {
    try {
      // Generate all random IDs first
      final randomIds = List.generate(10, (_) => _random.nextInt(1025) + 1);

      // Fetch all pokemons in parallel
      final pokemonResults = await Future.wait(
        randomIds.map((id) => _repository.searchPokemon(id.toString())),
      );

      // Filter out null results and get unique ability IDs
      final validPokemons =
          pokemonResults.where((result) => result.$1 != null).toList();
      final allAbilityIds = validPokemons
          .expand((result) => result.$2)
          .toSet() // Remove duplicates
          .toList();

      // Fetch all unique abilities in parallel
      final abilities = await Future.wait(
        allAbilityIds.map((id) => _repository.searchAbility(id)),
      );
      final abilityMap = {
        for (var ability in abilities)
          if (ability != null) ability.id: ability
      };

      // Enrich pokemons with their abilities
      return validPokemons.map((result) {
        final pokemon = result.$1!;
        final pokemonAbilities = result.$2
            .map((id) => abilityMap[id])
            .where((ability) => ability != null)
            .cast<Ability>()
            .toList();
        return pokemon.copyWith(abilities: pokemonAbilities);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load random pokemons: $e');
    }
  }

  Future<Pokemon?> searchPokemonByName(String name) async {
    try {
      final (pokemon, abilityIds) = await _repository.searchPokemon(name);

      if (pokemon != null) {
        // Fetch all abilities in parallel
        final abilities = await Future.wait(
          abilityIds.map((id) => _repository.searchAbility(id)),
        );
        final pokemonAbilities = abilities
            .where((ability) => ability != null)
            .cast<Ability>()
            .toList();
        return pokemon.copyWith(abilities: pokemonAbilities);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to search pokemon: $e');
    }
  }
}

@riverpod
SearchService searchService(Ref ref) {
  final repository = ref.watch(pokemonsRepositoryProvider);
  return SearchService(repository);
}
