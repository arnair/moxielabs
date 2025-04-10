import 'package:flutter_pokedex/features/search/domain/ability_model.dart';
import 'package:flutter_pokedex/features/search/domain/pokemon_types_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_model.freezed.dart';
part 'pokemon_model.g.dart';

@freezed
abstract class Pokemon with _$Pokemon {
  const Pokemon._();

  const factory Pokemon({
    required int id,
    required String name,
    required String imageUrl,
    required List<PokemonTypes> type,
    @Default(false) bool captured,
    required List<Ability> abilities,
  }) = _Pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  factory Pokemon.pokemonApiJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] as int,
      name: (json['name'] as String)[0].toUpperCase() +
          (json['name'] as String).substring(1),
      imageUrl:
          json['sprites']['other']['dream_world']['front_default'] as String? ??
              json['sprites']['front_default'] as String? ??
              '',
      type: (json['types'] as List)
          .map((typeJson) =>
              PokemonTypes.fromString(typeJson['type']['name'] as String))
          .toList(),
      abilities: [],
    );
  }

  static List<int> extractAbilityIds(Map<String, dynamic> json) {
    List<int> abilityIds = [];
    if (json['abilities'] != null) {
      for (var ability in json['abilities']) {
        if (ability['ability'] != null && ability['ability']['url'] != null) {
          String url = ability['ability']['url'];
          int id = int.parse(url.split('/').where((s) => s.isNotEmpty).last);
          abilityIds.add(id);
        }
      }
    }
    return abilityIds;
  }
}
