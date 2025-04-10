import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pokedex/main.dart';
import 'package:flutter_pokedex/features/authentication/presentation/login_screen.dart';
import 'package:flutter_pokedex/features/my_pokedex/presentation/my_pokedex_screen.dart';
import 'package:flutter_pokedex/features/home/presentation/home_switch.dart';
import 'package:flutter_pokedex/common_widgets/pokemon_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'dart:math';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Pokédex Flow Test', () {
    late String username;

    setUp(() {
      // Generate a random 2-digit number for the username
      final random = Random();
      final number = random.nextInt(90) + 10; // Generates number between 10-99
      username = 'integration $number';
    });

    testWidgets('Complete Pokédex Flow', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(const ProviderScope(child: Pokedex()));
      await tester.pumpAndSettle();

      // Verify we're on the login screen
      expect(find.byType(LoginScreen), findsOneWidget);

      // Switch to register mode
      await tester.tap(find.text('New Trainer? Register here'));
      await tester.pumpAndSettle();

      // Find the username and password fields
      final usernameField = find.widgetWithText(TextFormField, 'Username');
      final passwordField = find.widgetWithText(TextFormField, 'Password');

      // Enter credentials for registration
      await tester.enterText(usernameField, username);
      await tester.enterText(passwordField, '123456');

      // Tap the register button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Switch to search view using the HomeSwitch
      final searchSwitch = find.byType(HomeSwitch);
      expect(searchSwitch, findsOneWidget);
      await tester.tap(searchSwitch);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Find the search field and enter "charmander"
      final searchField = find.byType(TextField);
      await tester.enterText(searchField, 'charmander');
      await tester.pumpAndSettle();

      // Tap the search button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Search'));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2)); // Wait for search results

      // Find and tap the "Add to Pokédex" button
      final addButton = find.widgetWithText(TextButton, 'Add to Pokédex');
      expect(addButton, findsOneWidget);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // Switch back to Pokédex view
      await tester.tap(searchSwitch);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 2)); // Wait for state to update

      // Verify we're on the Pokédex screen
      expect(find.byType(MyPokedexScreen), findsOneWidget);

      // Find the SearchCard widget containing Charmander
      final searchCard = find.byWidgetPredicate((widget) {
        if (widget is SearchCard) {
          return widget.pokemon.name.toLowerCase() == 'charmander';
        }
        return false;
      });

      // Verify Charmander's SearchCard is in the Pokédex
      expect(searchCard, findsOneWidget,
          reason: 'Should find Charmander\'s SearchCard in the Pokédex');
    });
  });
}
