import 'package:drift/drift.dart';
import 'dart:convert';

// Data classes
class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String password;
  final bool isLoggedIn;
  final DateTime? lastLogin;

  const User({
    required this.id,
    required this.username,
    required this.password,
    required this.isLoggedIn,
    this.lastLogin,
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = {
      'id': Variable<int>(id),
      'username': Variable<String>(username),
      'password': Variable<String>(password),
      'is_logged_in': Variable<bool>(isLoggedIn),
    };
    if (!nullToAbsent || lastLogin != null) {
      map['last_login'] = Variable<DateTime>(lastLogin!);
    }
    return map;
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    return {
      'id': id,
      'username': username,
      'password': password,
      'isLoggedIn': isLoggedIn,
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }
}

class PokemonData extends DataClass implements Insertable<PokemonData> {
  final int id;
  final String name;
  final String imageUrl;
  final String types;
  final bool captured;
  final String generation;
  final String effectEntries;
  final int? order;
  final int userId;

  const PokemonData({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.captured,
    required this.generation,
    required this.effectEntries,
    this.order,
    required this.userId,
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = {
      'id': Variable<int>(id),
      'name': Variable<String>(name),
      'image_url': Variable<String>(imageUrl),
      'types': Variable<String>(types),
      'captured': Variable<bool>(captured),
      'generation': Variable<String>(generation),
      'effect_entries': Variable<String>(effectEntries),
      'user_id': Variable<int>(userId),
    };
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order!);
    }
    return map;
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'types': types,
      'captured': captured,
      'generation': generation,
      'effectEntries': effectEntries,
      'order': order,
      'userId': userId,
    };
  }
}

// Table definitions
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().withLength(min: 3, max: 50)();
  TextColumn get password => text().withLength(min: 6, max: 50)();
  BoolColumn get isLoggedIn => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastLogin => dateTime().nullable()();
}

class Pokemon extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get imageUrl => text()();
  TextColumn get types => text()();
  BoolColumn get captured => boolean().withDefault(const Constant(false))();
  TextColumn get generation => text()();
  TextColumn get effectEntries => text()();
  IntColumn get order => integer().nullable()();
  IntColumn get userId => integer()();

  @override
  Set<Column> get primaryKey => {id, userId};
}

// Custom companion for Users
class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> password;
  final Value<bool> isLoggedIn;
  final Value<DateTime?> lastLogin;

  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.isLoggedIn = const Value.absent(),
    this.lastLogin = const Value.absent(),
  });

  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String password,
    bool isLoggedIn = false,
    DateTime? lastLogin,
  })  : username = Value(username),
        password = Value(password),
        isLoggedIn = Value(isLoggedIn),
        lastLogin = Value(lastLogin);

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (isLoggedIn.present) {
      map['is_logged_in'] = Variable<bool>(isLoggedIn.value);
    }
    if (lastLogin.present) {
      map['last_login'] = Variable<DateTime>(lastLogin.value!);
    }
    return map;
  }
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
  final Value<int> userId;

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
    required int id,
    required String name,
    required String imageUrl,
    required String types,
    bool captured = false,
    required String generation,
    required String effectEntries,
    int? order,
    required int userId,
  })  : id = Value(id),
        name = Value(name),
        imageUrl = Value(imageUrl),
        types = Value(types),
        captured = Value(captured),
        generation = Value(generation),
        effectEntries = Value(effectEntries),
        order = Value(order),
        userId = Value(userId);

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (types.present) {
      map['types'] = Variable<String>(types.value);
    }
    if (captured.present) {
      map['captured'] = Variable<bool>(captured.value);
    }
    if (generation.present) {
      map['generation'] = Variable<String>(generation.value);
    }
    if (effectEntries.present) {
      map['effect_entries'] = Variable<String>(effectEntries.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value!);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    return map;
  }
}
