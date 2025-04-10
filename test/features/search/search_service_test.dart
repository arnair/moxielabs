import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pokedex/features/search/application/search_service.dart';
import 'package:flutter_pokedex/features/search/data/search_repository.dart';
import 'package:flutter_pokedex/features/search/domain/pokemon_model.dart';
import 'package:flutter_pokedex/features/search/domain/ability_model.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([SearchRepository])
import 'search_service_test.mocks.dart';

void main() {
  late SearchService searchService;
  late MockSearchRepository mockRepository;

  setUp(() {
    mockRepository = MockSearchRepository();
    searchService = SearchService(mockRepository);
  });

  group('SearchService Tests', () {
    test('searchPokemonByName returns Pokemon when found', () async {
      // Arrange
      final testPokemon = Pokemon(
        id: 1,
        name: 'Pikachu',
        imageUrl: 'https://example.com/pikachu.png',
        type: [],
        abilities: [],
      );
      final testAbilityIds = [1, 2];
      final testAbilities = [
        Ability(
          id: 1,
          abilityName: 'Static',
          generation: 'Generation 1',
          shortEffect: 'May paralyze opponent',
        ),
        Ability(
          id: 2,
          abilityName: 'Lightning Rod',
          generation: 'Generation 3',
          shortEffect: 'Draws electric moves',
        ),
      ];

      when(mockRepository.searchPokemon('pikachu'))
          .thenAnswer((_) async => (testPokemon, testAbilityIds));
      when(mockRepository.searchAbility(1))
          .thenAnswer((_) async => testAbilities[0]);
      when(mockRepository.searchAbility(2))
          .thenAnswer((_) async => testAbilities[1]);

      // Act
      final result = await searchService.searchPokemonByName('pikachu');

      // Assert
      expect(result, isNotNull);
      expect(result!.name, 'Pikachu');
      expect(result.abilities.length, 2);
      expect(result.abilities[0].abilityName, 'Static');
      expect(result.abilities[1].abilityName, 'Lightning Rod');
    });

    test('searchPokemonByName returns null when Pokemon not found', () async {
      // Arrange
      when(mockRepository.searchPokemon('unknown'))
          .thenAnswer((_) async => (null, <int>[]));

      // Act
      final result = await searchService.searchPokemonByName('unknown');

      // Assert
      expect(result, isNull);
    });

    test('getRandomPokemons returns list of Pokemon', () async {
      // Arrange
      final testPokemon = Pokemon(
        id: 1,
        name: 'Pikachu',
        imageUrl: 'https://example.com/pikachu.png',
        type: [],
        abilities: [],
      );
      final testAbilityIds = [1];
      final testAbility = Ability(
        id: 1,
        abilityName: 'Static',
        generation: 'Generation 1',
        shortEffect: 'May paralyze opponent',
      );

      when(mockRepository.searchPokemon(any))
          .thenAnswer((_) async => (testPokemon, testAbilityIds));
      when(mockRepository.searchAbility(1))
          .thenAnswer((_) async => testAbility);

      // Act
      final result = await searchService.getRandomPokemons();

      // Assert
      expect(result, isNotEmpty);
      expect(result.length, 10);
      expect(result[0].name, 'Pikachu');
      expect(result[0].abilities.length, 1);
      expect(result[0].abilities[0].abilityName, 'Static');
    });
  });
}
