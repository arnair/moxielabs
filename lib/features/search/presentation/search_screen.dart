import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/constants/palette.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';
import 'package:flutter_pokedex/common_widgets/pokemon_card.dart';
import 'package:flutter_pokedex/features/search/presentation/search_controller.dart';
import 'package:flutter_pokedex/features/search/domain/pokemon_model.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Pokemon? selectedPokemon;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void onPokemonSelected(Pokemon pokemon) {
    setState(() {
      selectedPokemon = pokemon;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonList = ref.watch(searchControllerProvider);
    final filteredList = filterPokemonList(
      pokemonList: pokemonList,
      searchText: _searchController.text,
      showCaptured: false,
      controller: ref.read(searchControllerProvider.notifier),
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              children: [
                TextField(
                  cursorColor: Colors.black,
                  style: AppTextStyle.normalBlack,
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search pokémons...',
                    hintStyle:
                        AppTextStyle.normalBlack.copyWith(color: Colors.grey),
                    icon: const Icon(Icons.search, color: Colors.black),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.black),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                              });
                            },
                          )
                        : null,
                  ),
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
                        if (_searchController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Empty Search'),
                              content: const Text(
                                  'Please enter a Pokémon name to search.'),
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

                        await ref
                            .read(searchControllerProvider.notifier)
                            .searchPokemon(_searchController.text);
                        if (!mounted) return;

                        if (filteredList.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('No Results Found'),
                              content: Text(
                                  'No Pokémon found with "${_searchController.text}". Please try again with a different spelling.'),
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
                            .read(searchControllerProvider.notifier)
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
                        showCaptured: false,
                        index: index,
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
