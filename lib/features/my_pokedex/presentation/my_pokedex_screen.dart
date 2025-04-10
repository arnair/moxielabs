import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';
import 'package:flutter_pokedex/features/search/presentation/search_controller.dart';
import 'package:flutter_pokedex/features/search/domain/pokemon_model.dart';
import 'package:flutter_pokedex/common_widgets/pokemon_card.dart';

class MyPokedexScreen extends ConsumerStatefulWidget {
  const MyPokedexScreen({super.key});

  @override
  ConsumerState<MyPokedexScreen> createState() => _MyPokedexScreenState();
}

class _MyPokedexScreenState extends ConsumerState<MyPokedexScreen> {
  @override
  Widget build(BuildContext context) {
    final pokemonList = ref.watch(searchControllerProvider);
    final capturedPokemon =
        pokemonList.where((pokemon) => pokemon.captured).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: capturedPokemon.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Text(
                        'No Pokémon captured yet. Use the Search screen to find and capture Pokémon!',
                        style: AppTextStyle.normalBlack,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ReorderableListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: capturedPokemon.length,
                    onReorder: (oldIndex, newIndex) {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final List<Pokemon> newList = List.from(capturedPokemon);
                      final Pokemon item = newList.removeAt(oldIndex);
                      newList.insert(newIndex, item);
                      ref
                          .read(searchControllerProvider.notifier)
                          .reorderPokemon(newList);
                    },
                    itemBuilder: (context, index) {
                      Pokemon pokemon = capturedPokemon[index];
                      return Padding(
                        key: ValueKey(pokemon.id),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: SearchCard(
                          pokemon: pokemon,
                          showCaptured: true,
                          index: index,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
