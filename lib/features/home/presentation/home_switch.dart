import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/palette.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';

class HomeSwitch extends StatelessWidget {
  final bool showPokedex;
  final void Function() togglePokedex;
  final double containerWidth = 360.0;
  final double containerHeight = 40.0;

  const HomeSwitch({
    super.key,
    required this.showPokedex,
    required this.togglePokedex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 10,
      ),
      child: SizedBox(
        height: containerHeight,
        width: containerWidth,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                border: Border.all(),
                borderRadius: BorderRadius.circular(containerHeight / 2),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: !showPokedex ? 0 : (containerWidth / 2),
              child: Container(
                margin: const EdgeInsets.only(top: 1),
                decoration: BoxDecoration(
                  color: Palette.yellow,
                  borderRadius: BorderRadius.circular(containerHeight / 2),
                ),
                height: containerHeight - 2,
                width: containerWidth / 2,
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
                          style: !showPokedex
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
                          'Pokédex',
                          style: showPokedex
                              ? AppTextStyle.titleBlack
                              : AppTextStyle.titleWhite,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: togglePokedex,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(containerHeight / 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
