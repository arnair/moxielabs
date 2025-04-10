import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_pokedex/features/my_pokedex/application/pokedex_service.dart';
import 'package:flutter_pokedex/features/search/domain/pokemon_model.dart';
import 'package:flutter_pokedex/features/authentication/domain/user_model.dart';

part 'pokedex_controller.g.dart';

@riverpod
class PokedexController extends _$PokedexController {
  late final PokedexService _service;
  late final User _currentUser;

  @override
  List<Pokemon> build(User user) {
    _service = ref.watch(pokedexServiceProvider);
    _currentUser = user;
    return [];
  }

  Stream<List<Pokemon>> watchCapturedPokemon() {
    return _service.watchCapturedPokemon(_currentUser.id);
  }

  Future<void> addPokemonToPokedex(Pokemon pokemon) async {
    await _service.addPokemonToPokedex(pokemon, _currentUser.id);
  }

  Future<void> removePokemonFromPokedex(Pokemon pokemon) async {
    await _service.removePokemonFromPokedex(pokemon, _currentUser.id);
  }

  Future<void> reorderPokemon(List<Pokemon> pokemonList) async {
    await _service.reorderPokemon(pokemonList, _currentUser.id);
  }
}
