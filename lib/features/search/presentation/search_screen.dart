import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/common_widgets/pokemon_card.dart';
import 'package:flutter_pokedex/features/search/domain/pokemon_model.dart';
import 'package:flutter_pokedex/features/search/presentation/search_controller.dart';
import 'package:flutter_pokedex/features/authentication/domain/user_model.dart';
import 'package:flutter_pokedex/features/my_pokedex/presentation/pokedex_controller.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';
import 'package:flutter_pokedex/constants/palette.dart';

class SearchScreen extends ConsumerStatefulWidget {
  final User user;

  const SearchScreen({super.key, required this.user});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  StreamSubscription<List<Pokemon>>? _subscription;

  @override
  void initState() {
    super.initState();
    // Load the user's saved surprise pokemon list
    _subscription = ref
        .read(searchControllerProvider(widget.user).notifier)
        .watchSurprisePokemonList()
        .listen((pokemons) {
      if (pokemons.isNotEmpty && mounted) {
        ref.read(searchControllerProvider(widget.user).notifier).state =
            pokemons;
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = ref.watch(searchControllerProvider(widget.user));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for a Pokémon...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                onSubmitted: (value) async {
                  await ref
                      .read(searchControllerProvider(widget.user).notifier)
                      .searchPokemon(value);
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.yellow,
                    ),
                    onPressed: () async {
                      if (_searchController.text.trim().isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Empty search'),
                            content: const Text(
                                'Please enter a Pokémon name to search for.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                        return;
                      }

                      final found = await ref
                          .read(searchControllerProvider(widget.user).notifier)
                          .searchPokemon(_searchController.text);

                      if (!found) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Pokémon Not Found'),
                            content: Text(
                                'No Pokémon found with the name "${_searchController.text}".\nPlease check the spelling and try again.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child:
                        const Text('Search', style: AppTextStyle.normalBlack),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.yellow,
                    ),
                    onPressed: () async {
                      await ref
                          .read(searchControllerProvider(widget.user).notifier)
                          .getRandomPokemon();
                    },
                    child: const Text('Surprise Me!',
                        style: AppTextStyle.normalBlack),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: filteredList.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      'By default here it will show the local saved pokemons from the latest surprise button',
                      style: AppTextStyle.normalBlack,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    Pokemon pokemon = filteredList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: SearchCard(
                        pokemon: pokemon,
                        index: index,
                        onAddToPokedex: () async {
                          // First update the search list state to show the Pokémon as captured
                          ref
                              .read(searchControllerProvider(widget.user)
                                  .notifier)
                              .updatePokemonState(
                                  pokemon.copyWith(captured: true));

                          // Then add it to the Pokédex
                          await ref
                              .read(pokedexControllerProvider(widget.user)
                                  .notifier)
                              .addPokemonToPokedex(
                                  pokemon.copyWith(captured: true));
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
