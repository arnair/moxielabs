import 'package:drift/drift.dart';

// Database tables
@DataClassName('UserData')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().withLength(min: 3, max: 50)();
  TextColumn get password => text().withLength(min: 6, max: 50)();
  BoolColumn get isLoggedIn => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastLogin => dateTime().nullable()();
  TextColumn get sessionToken => text().nullable()();
}

@DataClassName('PokemonData')
class Pokemon extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get imageUrl => text()();
  TextColumn get types => text()(); // JSON string of PokemonTypes enum values
  BoolColumn get captured => boolean().withDefault(const Constant(false))();
  TextColumn get generation => text()();
  TextColumn get effectEntries => text()(); // JSON string of List<String>
  IntColumn get order => integer().nullable()(); // For custom ordering
  IntColumn get userId => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
