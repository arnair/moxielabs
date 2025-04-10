import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/fonts.dart';

class AppTextStyle {
  //// PokemonNames
  static const TextStyle normalWhite = TextStyle(
    fontSize: 16,
    fontFamily: Fonts.primary,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  //// PokemonTitle
  static const TextStyle titleWhite = TextStyle(
    fontSize: 24,
    fontFamily: Fonts.primary,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  //// PokemonTitle
  static const TextStyle titleBlack = TextStyle(
    fontSize: 24,
    fontFamily: Fonts.primary,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  //// Normal
  static const TextStyle normalBlack = TextStyle(
    fontSize: 16,
    fontFamily: Fonts.primary,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  //// Large White
  static const TextStyle largeWhite = TextStyle(
    fontSize: 32,
    fontFamily: Fonts.primary,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  //// Small White
  static const TextStyle smallWhite = TextStyle(
    fontSize: 12,
    fontFamily: Fonts.primary,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
}
