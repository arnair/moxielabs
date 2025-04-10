import 'package:drift/drift.dart';

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
