import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pokedex/common_widgets/pokemon_card.dart';
import 'package:flutter_pokedex/features/search/domain/pokemon_model.dart';
import 'package:flutter_pokedex/features/search/domain/pokemon_types_enum.dart';
import 'package:flutter_pokedex/features/search/domain/ability_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('SearchCard Widget Tests', () {
    testWidgets('displays Pokemon information correctly',
        (WidgetTester tester) async {
      // Create a test Pokemon
      final testPokemon = Pokemon(
        id: 1,
        name: 'Pikachu',
        imageUrl: '', // Empty URL will show placeholder
        type: [PokemonTypes.electric],
        abilities: [
          Ability(
            id: 1,
            abilityName: 'Static',
            generation: 'Generation 1',
            shortEffect: 'May paralyze opponent',
          ),
        ],
      );

      // Build the widget
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: SearchCard(
                pokemon: testPokemon,
                onAddToPokedex: () {},
              ),
            ),
          ),
        ),
      );

      // Pump a frame to handle image loading
      await tester.pump();

      // Verify Pokemon name is displayed
      expect(find.text('Pikachu'), findsOneWidget);

      // Verify Pokemon type is displayed
      expect(find.text('Electric'), findsOneWidget);

      // Verify ability information is displayed
      expect(find.text('Static'), findsOneWidget);
      expect(find.text('May paralyze opponent'), findsOneWidget);

      // Verify "Add to Pokédex" button is present
      expect(find.text('Add to Pokédex'), findsOneWidget);

      // Verify placeholder icon is shown
      final iconFinder = find.byIcon(Icons.catching_pokemon);
      expect(iconFinder, findsOneWidget);

      // Verify the icon size is 48 (placeholder size)
      final Icon icon = tester.widget(iconFinder);
      expect(icon.size, 48);

      // Ignore image loading errors in test
      await tester.pumpAndSettle(
          const Duration(seconds: 1), EnginePhase.sendSemanticsUpdate);
    });

    testWidgets('shows captured state correctly', (WidgetTester tester) async {
      // Create a test Pokemon that is captured
      final testPokemon = Pokemon(
        id: 1,
        name: 'Pikachu',
        imageUrl: '', // Empty URL will show placeholder
        type: [PokemonTypes.electric],
        captured: true,
        abilities: [],
      );

      // Build the widget
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: SearchCard(
                pokemon: testPokemon,
                onAddToPokedex: () {},
              ),
            ),
          ),
        ),
      );

      // Pump a frame to handle image loading
      await tester.pump();

      // Verify "CAUGHT" text is displayed
      expect(find.text('CAUGHT'), findsOneWidget);

      // Verify both icons are shown (placeholder and caught state)
      final iconFinder = find.byIcon(Icons.catching_pokemon);
      expect(iconFinder, findsNWidgets(2));

      // Find the placeholder icon (size 48) and the caught state icon (size 16)
      final icons = tester.widgetList<Icon>(iconFinder);
      expect(icons.where((icon) => icon.size == 48), hasLength(1));
      expect(icons.where((icon) => icon.size == 16), hasLength(1));

      // Ignore image loading errors in test
      await tester.pumpAndSettle(
          const Duration(seconds: 1), EnginePhase.sendSemanticsUpdate);
    });

    testWidgets('calls onAddToPokedex when button is pressed',
        (WidgetTester tester) async {
      bool buttonPressed = false;

      // Create a test Pokemon
      final testPokemon = Pokemon(
        id: 1,
        name: 'Pikachu',
        imageUrl: '', // Empty URL will show placeholder
        type: [PokemonTypes.electric],
        abilities: [],
      );

      // Build the widget
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: SearchCard(
                pokemon: testPokemon,
                onAddToPokedex: () {
                  buttonPressed = true;
                },
              ),
            ),
          ),
        ),
      );

      // Pump a frame to handle image loading
      await tester.pump();

      // Tap the "Add to Pokédex" button
      await tester.tap(find.text('Add to Pokédex'));
      await tester.pump();

      // Verify the callback was called
      expect(buttonPressed, isTrue);

      // Verify placeholder icon is shown
      final iconFinder = find.byIcon(Icons.catching_pokemon);
      expect(iconFinder, findsOneWidget);

      // Verify the icon size is 48 (placeholder size)
      final Icon icon = tester.widget(iconFinder);
      expect(icon.size, 48);

      // Ignore image loading errors in test
      await tester.pumpAndSettle(
          const Duration(seconds: 1), EnginePhase.sendSemanticsUpdate);
    });
  });
}
