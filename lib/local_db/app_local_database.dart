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
  DateTimeColumn get lastLogin => dateTime().nullable()();
  TextColumn get sessionToken => text().nullable()();
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
  IntColumn get userId => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Custom companion for Pokemon
class CustomPokemonCompanion extends UpdateCompanion<PokemonData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> imageUrl;
  final Value<String> types;
  final Value<bool> captured;
  final Value<String> generation;
  final Value<String> effectEntries;
  final Value<int?> order;
  final Value<int?> userId;

  const CustomPokemonCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.types = const Value.absent(),
    this.captured = const Value.absent(),
    this.generation = const Value.absent(),
    this.effectEntries = const Value.absent(),
    this.order = const Value.absent(),
    this.userId = const Value.absent(),
  });

  CustomPokemonCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String imageUrl,
    required String types,
    bool captured = false,
    required String generation,
    required String effectEntries,
    int? order,
    int? userId,
  })  : name = Value(name),
        imageUrl = Value(imageUrl),
        types = Value(types),
        captured = Value(captured),
        generation = Value(generation),
        effectEntries = Value(effectEntries),
        order = Value(order),
        userId = Value(userId);

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return {
      if (id.present) 'id': Variable<int>(id.value),
      if (name.present) 'name': Variable<String>(name.value),
      if (imageUrl.present) 'image_url': Variable<String>(imageUrl.value),
      if (types.present) 'types': Variable<String>(types.value),
      if (captured.present) 'captured': Variable<bool>(captured.value),
      if (generation.present) 'generation': Variable<String>(generation.value),
      if (effectEntries.present)
        'effect_entries': Variable<String>(effectEntries.value),
      if (order.present) 'order': Variable<int>(order.value),
      if (userId.present) 'user_id': Variable<int>(userId.value),
    };
  }
}

@DriftDatabase(tables: [Users, Pokemon])
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
    );
  }

  // User operations
  Future<int> createUser(UsersCompanion user) => into(users).insert(user);

  Future<User?> getUserByUsername(String username) {
    return (select(users)..where((tbl) => tbl.username.equals(username)))
        .getSingleOrNull();
  }

  Future<bool> updateUserLoginStatus(int id, bool isLoggedIn) {
    final now = DateTime.now();
    return (update(users)..where((tbl) => tbl.id.equals(id)))
        .write(UsersCompanion(
          isLoggedIn: Value(isLoggedIn),
          lastLogin: Value(isLoggedIn ? now : null),
        ))
        .then((rowsAffected) => rowsAffected > 0);
  }

  // Pokemon operations
  Future<void> replaceSurprisePokemons(
      List<PokemonData> pokemons, int userId) async {
    // Delete existing surprise pokemons for this user
    await (delete(pokemon)
          ..where(
              (tbl) => tbl.userId.equals(userId) & tbl.captured.equals(false)))
        .go();

    // Insert new pokemons
    await batch((batch) {
      batch.insertAll(pokemon, pokemons);
    });
  }

  Future<void> updatePokemonOrder(int id, int userId, int order) {
    return (update(pokemon)
          ..where((tbl) => tbl.id.equals(id) & tbl.userId.equals(userId)))
        .write(CustomPokemonCompanion(order: Value(order)));
  }

  Future<void> setPokemonCaptured(int id, int userId, bool isCaptured) {
    return (update(pokemon)
          ..where((tbl) => tbl.id.equals(id) & tbl.userId.equals(userId)))
        .write(CustomPokemonCompanion(captured: Value(isCaptured)));
  }

  Stream<List<PokemonData>> watchSurprisePokemons(int userId) {
    return (select(pokemon)
          ..where(
              (tbl) => tbl.userId.equals(userId) & tbl.captured.equals(false)))
        .watch();
  }

  Stream<List<PokemonData>> watchCapturedPokemons(int userId) {
    return (select(pokemon)
          ..where(
              (tbl) => tbl.userId.equals(userId) & tbl.captured.equals(true))
          ..orderBy([
            (t) => OrderingTerm(
                expression: t.order,
                mode: OrderingMode.asc,
                nulls: NullsOrder.last)
          ]))
        .watch();
  }

  // Helper methods for Pokemon model conversion
  PokemonData toPokemonData(Map<String, dynamic> json, int userId) {
    return PokemonData(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      types: jsonEncode((json['type'] as List<PokemonTypes>)
          .map((type) => type.toString())
          .toList()),
      captured: json['captured'] as bool,
      generation: json['generation'] as String,
      effectEntries: jsonEncode(json['effectEntries'] as List<String>),
      userId: userId,
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
