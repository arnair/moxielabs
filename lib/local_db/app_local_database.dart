import 'dart:io';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/features/search/domain/pokemon_types_enum.dart';

part 'app_local_database.g.dart';

// Database tables
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().withLength(min: 3, max: 50)();
  TextColumn get password => text().withLength(min: 6, max: 50)();
  BoolColumn get isLoggedIn => boolean().withDefault(const Constant(false))();
}

class Pokemon extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get imageUrl => text()();
  TextColumn get types =>
      text()(); // Storing as JSON string of PokemonTypes enum values
  BoolColumn get captured => boolean().withDefault(const Constant(false))();
  TextColumn get generation => text()();
  TextColumn get effectEntries =>
      text()(); // Storing as JSON string of List<String>
  IntColumn get order => integer().nullable()(); // For custom ordering

  @override
  Set<Column> get primaryKey => {id};
}

class SearchCache extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get query => text()();
  TextColumn get result => text()(); // Storing as JSON string
  DateTimeColumn get timestamp => dateTime()();
}

// Custom companion for SearchCache
class SearchCachesCompanion extends UpdateCompanion<SearchCacheData> {
  final Value<int> id;
  final Value<String> query;
  final Value<String> result;
  final Value<DateTime> timestamp;

  const SearchCachesCompanion({
    this.id = const Value.absent(),
    this.query = const Value.absent(),
    this.result = const Value.absent(),
    this.timestamp = const Value.absent(),
  });

  SearchCachesCompanion.insert({
    this.id = const Value.absent(),
    required String query,
    required String result,
    required DateTime timestamp,
  })  : query = Value(query),
        result = Value(result),
        timestamp = Value(timestamp);

  static Insertable<SearchCacheData> custom({
    Value<int> id = const Value.absent(),
    Value<String> query = const Value.absent(),
    Value<String> result = const Value.absent(),
    Value<DateTime> timestamp = const Value.absent(),
  }) {
    return RawValuesInsertable({
      if (id.present) 'id': Variable<int>(id.value),
      if (query.present) 'query': Variable<String>(query.value),
      if (result.present) 'result': Variable<String>(result.value),
      if (timestamp.present) 'timestamp': Variable<DateTime>(timestamp.value),
    });
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return {
      if (id.present) 'id': Variable<int>(id.value),
      if (query.present) 'query': Variable<String>(query.value),
      if (result.present) 'result': Variable<String>(result.value),
      if (timestamp.present) 'timestamp': Variable<DateTime>(timestamp.value),
    };
  }
}

class CustomPokemonCompanion extends UpdateCompanion<PokemonData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> imageUrl;
  final Value<String> types;
  final Value<bool> captured;
  final Value<String> generation;
  final Value<String> effectEntries;
  final Value<int?> order;

  const CustomPokemonCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.types = const Value.absent(),
    this.captured = const Value.absent(),
    this.generation = const Value.absent(),
    this.effectEntries = const Value.absent(),
    this.order = const Value.absent(),
  });

  CustomPokemonCompanion.insert({
    this.id = const Value.absent(),
    required Value<String> name,
    required Value<String> imageUrl,
    required Value<String> types,
    required Value<bool> captured,
    required Value<String> generation,
    required Value<String> effectEntries,
    this.order = const Value.absent(),
  })  : name = name,
        imageUrl = imageUrl,
        types = types,
        captured = captured,
        generation = generation,
        effectEntries = effectEntries;

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return {
      if (id.present) 'id': Variable<int>(id.value),
      if (name.present) 'name': Variable<String>(name.value),
      if (imageUrl.present) 'imageUrl': Variable<String>(imageUrl.value),
      if (types.present) 'types': Variable<String>(types.value),
      if (captured.present) 'captured': Variable<bool>(captured.value),
      if (generation.present) 'generation': Variable<String>(generation.value),
      if (effectEntries.present)
        'effectEntries': Variable<String>(effectEntries.value),
      if (order.present) 'order': Variable<int>(order.value),
    };
  }
}

@DriftDatabase(tables: [Users, Pokemon, SearchCache])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // Database version
  @override
  int get schemaVersion => 1;

  // Migration method if schema changes
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) {
        return m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Add future migrations here
      },
    );
  }

  // User operations
  Future<int> createUser(UsersCompanion user) => into(users).insert(user);

  Future<User?> getUserByUsername(String username) {
    return (select(users)..where((tbl) => tbl.username.equals(username)))
        .getSingleOrNull();
  }

  Future<bool> updateUserLoginStatus(int id, bool isLoggedIn) {
    return (update(users)..where((tbl) => tbl.id.equals(id)))
        .write(UsersCompanion(isLoggedIn: Value(isLoggedIn)))
        .then((rowsAffected) => rowsAffected > 0);
  }

  // Pokemon operations
  Future<int> addPokemon(CustomPokemonCompanion pokemon) =>
      into(this.pokemon).insert(pokemon);

  Future<bool> updatePokemon(CustomPokemonCompanion pokemon) {
    return (update(this.pokemon)
          ..where((tbl) => tbl.id.equals(pokemon.id.value)))
        .write(pokemon)
        .then((rowsAffected) => rowsAffected > 0);
  }

  Stream<List<PokemonData>> watchAllPokemons() => select(pokemon).watch();

  Stream<List<PokemonData>> watchCapturedPokemons() => (select(pokemon)
        ..where((tbl) => tbl.captured.equals(true))
        ..orderBy([
          (t) => OrderingTerm(
              expression: t.order,
              mode: OrderingMode.asc,
              nulls: NullsOrder.last)
        ]))
      .watch();

  Future<int> setPokemonCaptured(int id, bool isCaptured) {
    return (update(pokemon)..where((tbl) => tbl.id.equals(id)))
        .write(CustomPokemonCompanion(captured: Value(isCaptured)));
  }

  Future<int> updatePokemonOrder(int id, int order) {
    return (update(pokemon)..where((tbl) => tbl.id.equals(id)))
        .write(CustomPokemonCompanion(order: Value(order)));
  }

  // Search cache operations
  Future<int> addSearchCache(SearchCachesCompanion cache) =>
      into(searchCache).insert(cache);

  Future<SearchCacheData?> getCacheByQuery(String query) {
    return (select(searchCache)..where((tbl) => tbl.query.equals(query)))
        .getSingleOrNull();
  }

  // Helper methods for Pokemon model conversion
  CustomPokemonCompanion toPokemonCompanion(Map<String, dynamic> json) {
    return CustomPokemonCompanion.insert(
      id: Value(json['id'] as int),
      name: Value(json['name'] as String),
      imageUrl: Value(json['imageUrl'] as String),
      types: Value(jsonEncode((json['type'] as List<PokemonTypes>)
          .map((type) => type.toString())
          .toList())),
      captured: Value(json['captured'] as bool),
      generation: Value(json['generation'] as String),
      effectEntries: Value(jsonEncode(json['effectEntries'] as List<String>)),
    );
  }

  // Close method for cleaning up resources
  @override
  Future<void> close() {
    return executor.close();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'pokedex.sqlite'));
    return NativeDatabase(file);
  });
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
