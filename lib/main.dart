import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_pokedex/constants/fonts.dart';
import 'package:flutter_pokedex/constants/palette.dart';
import 'package:flutter_pokedex/routing/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  runApp(ProviderScope(child: Pokedex()));
}

final appRouterProvider = Provider<AppRouter>((ref) => AppRouter());

class Pokedex extends ConsumerWidget {
  const Pokedex({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Flutter Pokedex',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Palette.primary,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Palette.primary,
        ),
        fontFamily: Fonts.primary,
      ),
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
