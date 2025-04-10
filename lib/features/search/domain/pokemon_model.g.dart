// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Pokemon _$PokemonFromJson(Map<String, dynamic> json) => _Pokemon(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      type: (json['type'] as List<dynamic>)
          .map((e) => $enumDecode(_$PokemonTypesEnumMap, e))
          .toList(),
      captured: json['captured'] as bool? ?? false,
      abilities: (json['abilities'] as List<dynamic>)
          .map((e) => Ability.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokemonToJson(_Pokemon instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'type': instance.type.map((e) => _$PokemonTypesEnumMap[e]!).toList(),
      'captured': instance.captured,
      'abilities': instance.abilities,
    };

const _$PokemonTypesEnumMap = {
  PokemonTypes.bug: 'bug',
  PokemonTypes.dark: 'dark',
  PokemonTypes.dragon: 'dragon',
  PokemonTypes.electric: 'electric',
  PokemonTypes.fairy: 'fairy',
  PokemonTypes.fighting: 'fighting',
  PokemonTypes.fire: 'fire',
  PokemonTypes.flying: 'flying',
  PokemonTypes.ghost: 'ghost',
  PokemonTypes.grass: 'grass',
  PokemonTypes.ground: 'ground',
  PokemonTypes.ice: 'ice',
  PokemonTypes.normal: 'normal',
  PokemonTypes.poison: 'poison',
  PokemonTypes.psychic: 'psychic',
  PokemonTypes.rock: 'rock',
  PokemonTypes.steel: 'steel',
  PokemonTypes.water: 'water',
};
