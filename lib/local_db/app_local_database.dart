import 'dart:io';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/features/search/domain/pokemon_types_enum.dart';
import 'package:flutter_pokedex/local_db/tables/database_tables.dart';

part 'app_local_database.g.dart';

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

  // Core database operations for Users table
  Future<UserData?> getUserByUsername(String username) async {
    final query = select(users)..where((t) => t.username.equals(username));
    return await query.getSingleOrNull();
  }

  Future<int> createUser(String username, String password) async {
    final companion = UsersCompanion.insert(
      username: username,
      password: password,
      isLoggedIn: const Value(false),
    );
    return await into(users).insert(companion);
  }

  Future<void> updateUser(
    int id,
    String username,
    String password,
    bool isLoggedIn,
    DateTime? lastLogin,
    String? sessionToken,
  ) async {
    final companion = UsersCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
      isLoggedIn: Value(isLoggedIn),
      lastLogin: Value(lastLogin),
      sessionToken: Value(sessionToken),
    );
    await update(users).replace(companion);
  }

  Future<UserData?> getLoggedInUser() async {
    final query = select(users)..where((t) => t.isLoggedIn.equals(true));
    return await query.getSingleOrNull();
  }

  // Core database operations for Pokemon table
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
        .write(PokemonCompanion(order: Value(order)));
  }

  Future<void> setPokemonCaptured(int id, int userId, bool isCaptured) {
    return (update(pokemon)
          ..where((tbl) => tbl.id.equals(id) & tbl.userId.equals(userId)))
        .write(PokemonCompanion(captured: Value(isCaptured)));
  }

  Future<void> insertPokemon(PokemonData data) async {
    await into(pokemon).insert(data);
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
