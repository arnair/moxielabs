import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_pokedex/constants/palette.dart';
import 'package:flutter_pokedex/constants/sizes.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';

import 'package:flutter_pokedex/common_widgets/pokemon_card.dart';
import 'package:flutter_pokedex/features/search/domain/pokemon_types_enum.dart';
import 'package:flutter_pokedex/features/search/presentation/search_controller.dart';
import 'package:flutter_pokedex/features/search/presentation/search_switch.dart';

import '../domain/pokemon_model.dart';

@RoutePage()
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool showCaptured = false;
  bool showSide = false;
  Pokemon? selectedPokemon;

  @override
  void initState() {
    super.initState();
  }

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
      showCaptured: showCaptured,
      controller: ref.read(searchControllerProvider.notifier),
    );

    double screenWidth = MediaQuery.of(context).size.width;
    showSide = screenWidth > webWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        toolbarHeight: 100,
        backgroundColor: const Color(0xFFB71C1C),
        title: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Text(
                    'Ash Ketchum', // TODO: Get actual username from auth state
                    style: AppTextStyle.normalWhite.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: -12,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    onPressed: () {
                      // TODO: Implement logout
                      context.router.replaceNamed('/login');
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Logout',
                          style: AppTextStyle.normalWhite.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            SearchSwitch(
              showCaptured: showCaptured,
              toggleCaptured: () {
                setState(() {
                  showCaptured = !showCaptured;
                });
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          if (!showCaptured) ...[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16),
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
                        hintStyle: AppTextStyle.normalBlack
                            .copyWith(color: Colors.grey),
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                ),
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
                            if (ref.read(searchControllerProvider).isEmpty) {
                              if (!mounted) return;
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
                          child: const Text(
                            'Search',
                            style: AppTextStyle.normalBlack,
                          ),
                        ),
                        gapW16,
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Palette.yellow,
                          ),
                          onPressed: () async {
                            await ref
                                .read(searchControllerProvider.notifier)
                                .getRandomPokemon();
                          },
                          child: const Text(
                            'Surprise Me!',
                            style: AppTextStyle.normalBlack,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
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
                : Row(
                    children: [
                      Expanded(
                        flex: screenWidth > 1300 ? 2 : 1,
                        child: Container(
                          color: Colors.white,
                          child: showCaptured
                              ? ReorderableListView.builder(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  itemCount: filteredList.length,
                                  onReorder: (oldIndex, newIndex) {
                                    if (oldIndex < newIndex) {
                                      newIndex -= 1;
                                    }
                                    final List<Pokemon> newList =
                                        List.from(filteredList);
                                    final Pokemon item =
                                        newList.removeAt(oldIndex);
                                    newList.insert(newIndex, item);
                                    ref
                                        .read(searchControllerProvider.notifier)
                                        .reorderPokemon(newList);
                                  },
                                  itemBuilder: (context, index) {
                                    Pokemon pokemon = filteredList[index];
                                    return Padding(
                                      key: ValueKey(pokemon.id),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: SearchCard(
                                        pokemon: pokemon,
                                        showCaptured: showCaptured,
                                        index: index,
                                      ),
                                    );
                                  },
                                )
                              : ListView.builder(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  itemCount: filteredList.length,
                                  itemBuilder: (context, index) {
                                    Pokemon pokemon = filteredList[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: SearchCard(
                                        pokemon: pokemon,
                                        showCaptured: showCaptured,
                                        index: index,
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                      if (showSide && selectedPokemon != null)
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SearchCard(
                                  pokemon: selectedPokemon!,
                                  showCaptured: showCaptured,
                                  index: filteredList.indexWhere(
                                      (p) => p.id == selectedPokemon!.id),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
