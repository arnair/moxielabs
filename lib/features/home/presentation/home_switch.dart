import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/palette.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';

class HomeSwitch extends StatelessWidget {
  final bool showPokedex;
  final VoidCallback togglePokedex;
  final double containerWidth;
  final double containerHeight;

  const HomeSwitch({
    super.key,
    required this.showPokedex,
    required this.togglePokedex,
    required this.containerWidth,
    required this.containerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth,
      height: containerHeight,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(containerHeight / 2),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: showPokedex ? 0 : containerWidth / 2,
            child: Container(
              width: containerWidth / 2,
              height: containerHeight,
              decoration: BoxDecoration(
                color: Palette.yellow,
                borderRadius: BorderRadius.circular(containerHeight / 2),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: togglePokedex,
                  child: Container(
                    height: containerHeight,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        'Search',
                        style: showPokedex
                            ? AppTextStyle.titleBlack
                            : AppTextStyle.titleWhite,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: togglePokedex,
                  child: Container(
                    height: containerHeight,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        'Pokedex',
                        style: !showPokedex
                            ? AppTextStyle.titleBlack
                            : AppTextStyle.titleWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
