// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_pokedex/features/search/domain/pokemon_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/constants/palette.dart';

class SearchCard extends ConsumerWidget {
  final Pokemon pokemon;
  final bool showCaptured;
  final int? index;
  final VoidCallback? onAddToPokedex;

  const SearchCard({
    super.key,
    required this.pokemon,
    this.showCaptured = false,
    this.index,
    this.onAddToPokedex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              pokemon.type.first.color.withOpacity(0.2),
              Colors.white,
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pokemon Image and Types Column
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: pokemon.type.first.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: pokemon.imageUrl.endsWith('.svg')
                              ? SvgPicture.network(pokemon.imageUrl)
                              : Image.network(pokemon.imageUrl),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Types below image
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: pokemon.type
                          .map((type) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: type.color.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: type.color.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  type.name,
                                  style: TextStyle(
                                    color: type.color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                    // Add to Pokédex button or Remove from Captured button
                    Container(
                      width: 100,
                      height: 32,
                      decoration: BoxDecoration(
                        color: pokemon.captured
                            ? showCaptured
                                ? Palette.yellow
                                : pokemon.type.first.color.withOpacity(0.2)
                            : Palette.yellow,
                        borderRadius: BorderRadius.circular(16),
                        border: pokemon.captured
                            ? Border.all(
                                color: pokemon.type.first.color,
                                width: 1,
                              )
                            : Border.all(
                                color: Colors.black.withOpacity(0.2),
                                width: 1.5,
                              ),
                      ),
                      child: pokemon.captured
                          ? showCaptured
                              ? TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                  ),
                                  onPressed: () {
                                    if (onAddToPokedex != null) {
                                      onAddToPokedex!();
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 1),
                                        content: Text(
                                            '${pokemon.name} removed from your Pokédex!'),
                                        backgroundColor:
                                            pokemon.type.first.color,
                                      ),
                                    );
                                  },
                                  child: const FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Remove',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.catching_pokemon,
                                      color: pokemon.type.first.color,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'CAUGHT',
                                      style: TextStyle(
                                        color: pokemon.type.first.color,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                          : TextButton(
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                              ),
                              onPressed: () {
                                if (onAddToPokedex != null) {
                                  onAddToPokedex!();
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(seconds: 1),
                                    content: Text(
                                        '${pokemon.name} added to your Pokédex!'),
                                    backgroundColor: pokemon.type.first.color,
                                  ),
                                );
                              },
                              child: const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Add to Pokédex',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    if (showCaptured && index != null) ...[
                      const SizedBox(height: 8),
                      ReorderableDragStartListener(
                        index: index!,
                        child: Icon(
                          Icons.open_with,
                          color: pokemon.type.first.color,
                          size: 32,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(width: 16),
                // Pokemon Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pokemon.name,
                        style: AppTextStyle.normalBlack.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (pokemon.abilities.isNotEmpty) ...[
                        Text(
                          pokemon.abilities.first.generation,
                          style: AppTextStyle.normalBlack.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...pokemon.abilities.map((ability) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ability.abilityName,
                                  style: AppTextStyle.normalBlack.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ability.shortEffect,
                                  style: AppTextStyle.normalBlack.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            )),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
