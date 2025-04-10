import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';
import 'package:flutter_pokedex/constants/palette.dart';
import 'package:flutter_pokedex/features/search/presentation/search_screen.dart';
import 'package:flutter_pokedex/features/my_pokedex/presentation/my_pokedex_screen.dart';
import 'package:flutter_pokedex/features/authentication/presentation/login_controller.dart';
import 'package:flutter_pokedex/features/home/presentation/home_switch.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool showPokedex = false;
  final double containerWidth = 360.0;
  final double containerHeight = 40.0;

  final List<Widget> _screens = [
    const SearchScreen(),
    const MyPokedexScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final loginController = ref.read(loginControllerProvider.notifier);

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
                    currentUser?.username ?? 'Trainer',
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
                    onPressed: () async {
                      await loginController.logout();
                      if (mounted) {
                        context.router.replaceNamed('/login');
                      }
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
            HomeSwitch(
              showPokedex: showPokedex,
              togglePokedex: () => setState(() => showPokedex = !showPokedex),
            ),
          ],
        ),
      ),
      body: _screens[showPokedex ? 1 : 0],
    );
  }
}
