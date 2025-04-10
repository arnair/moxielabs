import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum PokemonTypes {
  bug(name: 'Bug', color: Color(0xFF94BC4A)),
  dark(name: 'Dark', color: Color(0xFF736C75)),
  dragon(name: 'Dragon', color: Color(0xFF6A7BAF)),
  electric(name: 'Electric', color: Color(0xFFE5C531)),
  fairy(name: 'Fairy', color: Color(0xFFE397D1)),
  fighting(name: 'Fighting', color: Color(0xFFCB5F48)),
  fire(name: 'Fire', color: Color(0xFFEA7A3C)),
  flying(name: 'Flying', color: Color(0xFF7DA6DE)),
  ghost(name: 'Ghost', color: Color(0xFF846AB6)),
  grass(name: 'Grass', color: Color(0xFF71C558)),
  ground(name: 'Ground', color: Color(0xFFCC9F4F)),
  ice(name: 'Ice', color: Color(0xFF70CBD4)),
  normal(name: 'Normal', color: Color(0xFFAAB09F)),
  poison(name: 'Poison', color: Color(0xFFB468B7)),
  psychic(name: 'Psychic', color: Color(0xFFE5709B)),
  rock(name: 'Rock', color: Color(0xFFB2A061)),
  steel(name: 'Steel', color: Color(0xFF89A1B0)),
  water(name: 'Water', color: Color(0xFF539AE2));

  final String name;
  final Color color;
  const PokemonTypes({this.name = '', this.color = Colors.black});

  static final _typeMap = {
    'normal': PokemonTypes.normal,
    'fire': PokemonTypes.fire,
    'water': PokemonTypes.water,
    'electric': PokemonTypes.electric,
    'grass': PokemonTypes.grass,
    'ice': PokemonTypes.ice,
    'fighting': PokemonTypes.fighting,
    'poison': PokemonTypes.poison,
    'ground': PokemonTypes.ground,
    'flying': PokemonTypes.flying,
    'psychic': PokemonTypes.psychic,
    'bug': PokemonTypes.bug,
    'rock': PokemonTypes.rock,
    'ghost': PokemonTypes.ghost,
    'dragon': PokemonTypes.dragon,
    'dark': PokemonTypes.dark,
    'steel': PokemonTypes.steel,
    'fairy': PokemonTypes.fairy,
  };

  static PokemonTypes fromString(String value) {
    return _typeMap[value.toLowerCase()] ?? PokemonTypes.normal;
  }

  @override
  String toString() => name;
}
