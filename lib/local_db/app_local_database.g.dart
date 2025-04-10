// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_local_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, UserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _isLoggedInMeta =
      const VerificationMeta('isLoggedIn');
  @override
  late final GeneratedColumn<bool> isLoggedIn = GeneratedColumn<bool>(
      'is_logged_in', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_logged_in" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _lastLoginMeta =
      const VerificationMeta('lastLogin');
  @override
  late final GeneratedColumn<DateTime> lastLogin = GeneratedColumn<DateTime>(
      'last_login', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _sessionTokenMeta =
      const VerificationMeta('sessionToken');
  @override
  late final GeneratedColumn<String> sessionToken = GeneratedColumn<String>(
      'session_token', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, username, password, isLoggedIn, lastLogin, sessionToken];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<UserData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('is_logged_in')) {
      context.handle(
          _isLoggedInMeta,
          isLoggedIn.isAcceptableOrUnknown(
              data['is_logged_in']!, _isLoggedInMeta));
    }
    if (data.containsKey('last_login')) {
      context.handle(_lastLoginMeta,
          lastLogin.isAcceptableOrUnknown(data['last_login']!, _lastLoginMeta));
    }
    if (data.containsKey('session_token')) {
      context.handle(
          _sessionTokenMeta,
          sessionToken.isAcceptableOrUnknown(
              data['session_token']!, _sessionTokenMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      isLoggedIn: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_logged_in'])!,
      lastLogin: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_login']),
      sessionToken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}session_token']),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class UserData extends DataClass implements Insertable<UserData> {
  final int id;
  final String username;
  final String password;
  final bool isLoggedIn;
  final DateTime? lastLogin;
  final String? sessionToken;
  const UserData(
      {required this.id,
      required this.username,
      required this.password,
      required this.isLoggedIn,
      this.lastLogin,
      this.sessionToken});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['is_logged_in'] = Variable<bool>(isLoggedIn);
    if (!nullToAbsent || lastLogin != null) {
      map['last_login'] = Variable<DateTime>(lastLogin);
    }
    if (!nullToAbsent || sessionToken != null) {
      map['session_token'] = Variable<String>(sessionToken);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
      isLoggedIn: Value(isLoggedIn),
      lastLogin: lastLogin == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLogin),
      sessionToken: sessionToken == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionToken),
    );
  }

  factory UserData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserData(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      isLoggedIn: serializer.fromJson<bool>(json['isLoggedIn']),
      lastLogin: serializer.fromJson<DateTime?>(json['lastLogin']),
      sessionToken: serializer.fromJson<String?>(json['sessionToken']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'isLoggedIn': serializer.toJson<bool>(isLoggedIn),
      'lastLogin': serializer.toJson<DateTime?>(lastLogin),
      'sessionToken': serializer.toJson<String?>(sessionToken),
    };
  }

  UserData copyWith(
          {int? id,
          String? username,
          String? password,
          bool? isLoggedIn,
          Value<DateTime?> lastLogin = const Value.absent(),
          Value<String?> sessionToken = const Value.absent()}) =>
      UserData(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        lastLogin: lastLogin.present ? lastLogin.value : this.lastLogin,
        sessionToken:
            sessionToken.present ? sessionToken.value : this.sessionToken,
      );
  UserData copyWithCompanion(UsersCompanion data) {
    return UserData(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      isLoggedIn:
          data.isLoggedIn.present ? data.isLoggedIn.value : this.isLoggedIn,
      lastLogin: data.lastLogin.present ? data.lastLogin.value : this.lastLogin,
      sessionToken: data.sessionToken.present
          ? data.sessionToken.value
          : this.sessionToken,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserData(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('isLoggedIn: $isLoggedIn, ')
          ..write('lastLogin: $lastLogin, ')
          ..write('sessionToken: $sessionToken')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, username, password, isLoggedIn, lastLogin, sessionToken);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserData &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.isLoggedIn == this.isLoggedIn &&
          other.lastLogin == this.lastLogin &&
          other.sessionToken == this.sessionToken);
}

class UsersCompanion extends UpdateCompanion<UserData> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> password;
  final Value<bool> isLoggedIn;
  final Value<DateTime?> lastLogin;
  final Value<String?> sessionToken;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.isLoggedIn = const Value.absent(),
    this.lastLogin = const Value.absent(),
    this.sessionToken = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String password,
    this.isLoggedIn = const Value.absent(),
    this.lastLogin = const Value.absent(),
    this.sessionToken = const Value.absent(),
  })  : username = Value(username),
        password = Value(password);
  static Insertable<UserData> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<bool>? isLoggedIn,
    Expression<DateTime>? lastLogin,
    Expression<String>? sessionToken,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (isLoggedIn != null) 'is_logged_in': isLoggedIn,
      if (lastLogin != null) 'last_login': lastLogin,
      if (sessionToken != null) 'session_token': sessionToken,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String>? password,
      Value<bool>? isLoggedIn,
      Value<DateTime?>? lastLogin,
      Value<String?>? sessionToken}) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      lastLogin: lastLogin ?? this.lastLogin,
      sessionToken: sessionToken ?? this.sessionToken,
    );
  }

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
      map['last_login'] = Variable<DateTime>(lastLogin.value);
    }
    if (sessionToken.present) {
      map['session_token'] = Variable<String>(sessionToken.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('isLoggedIn: $isLoggedIn, ')
          ..write('lastLogin: $lastLogin, ')
          ..write('sessionToken: $sessionToken')
          ..write(')'))
        .toString();
  }
}

class $PokemonTable extends Pokemon with TableInfo<$PokemonTable, PokemonData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typesMeta = const VerificationMeta('types');
  @override
  late final GeneratedColumn<String> types = GeneratedColumn<String>(
      'types', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _capturedMeta =
      const VerificationMeta('captured');
  @override
  late final GeneratedColumn<bool> captured = GeneratedColumn<bool>(
      'captured', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("captured" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _generationMeta =
      const VerificationMeta('generation');
  @override
  late final GeneratedColumn<String> generation = GeneratedColumn<String>(
      'generation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _effectEntriesMeta =
      const VerificationMeta('effectEntries');
  @override
  late final GeneratedColumn<String> effectEntries = GeneratedColumn<String>(
      'effect_entries', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        imageUrl,
        types,
        captured,
        generation,
        effectEntries,
        order,
        userId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon';
  @override
  VerificationContext validateIntegrity(Insertable<PokemonData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('types')) {
      context.handle(
          _typesMeta, types.isAcceptableOrUnknown(data['types']!, _typesMeta));
    } else if (isInserting) {
      context.missing(_typesMeta);
    }
    if (data.containsKey('captured')) {
      context.handle(_capturedMeta,
          captured.isAcceptableOrUnknown(data['captured']!, _capturedMeta));
    }
    if (data.containsKey('generation')) {
      context.handle(
          _generationMeta,
          generation.isAcceptableOrUnknown(
              data['generation']!, _generationMeta));
    } else if (isInserting) {
      context.missing(_generationMeta);
    }
    if (data.containsKey('effect_entries')) {
      context.handle(
          _effectEntriesMeta,
          effectEntries.isAcceptableOrUnknown(
              data['effect_entries']!, _effectEntriesMeta));
    } else if (isInserting) {
      context.missing(_effectEntriesMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url'])!,
      types: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}types'])!,
      captured: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}captured'])!,
      generation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}generation'])!,
      effectEntries: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}effect_entries'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
    );
  }

  @override
  $PokemonTable createAlias(String alias) {
    return $PokemonTable(attachedDatabase, alias);
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
  final int? userId;
  const PokemonData(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.types,
      required this.captured,
      required this.generation,
      required this.effectEntries,
      this.order,
      this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['image_url'] = Variable<String>(imageUrl);
    map['types'] = Variable<String>(types);
    map['captured'] = Variable<bool>(captured);
    map['generation'] = Variable<String>(generation);
    map['effect_entries'] = Variable<String>(effectEntries);
    if (!nullToAbsent || order != null) {
      map['order'] = Variable<int>(order);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    return map;
  }

  PokemonCompanion toCompanion(bool nullToAbsent) {
    return PokemonCompanion(
      id: Value(id),
      name: Value(name),
      imageUrl: Value(imageUrl),
      types: Value(types),
      captured: Value(captured),
      generation: Value(generation),
      effectEntries: Value(effectEntries),
      order:
          order == null && nullToAbsent ? const Value.absent() : Value(order),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
    );
  }

  factory PokemonData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      types: serializer.fromJson<String>(json['types']),
      captured: serializer.fromJson<bool>(json['captured']),
      generation: serializer.fromJson<String>(json['generation']),
      effectEntries: serializer.fromJson<String>(json['effectEntries']),
      order: serializer.fromJson<int?>(json['order']),
      userId: serializer.fromJson<int?>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'types': serializer.toJson<String>(types),
      'captured': serializer.toJson<bool>(captured),
      'generation': serializer.toJson<String>(generation),
      'effectEntries': serializer.toJson<String>(effectEntries),
      'order': serializer.toJson<int?>(order),
      'userId': serializer.toJson<int?>(userId),
    };
  }

  PokemonData copyWith(
          {int? id,
          String? name,
          String? imageUrl,
          String? types,
          bool? captured,
          String? generation,
          String? effectEntries,
          Value<int?> order = const Value.absent(),
          Value<int?> userId = const Value.absent()}) =>
      PokemonData(
        id: id ?? this.id,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        types: types ?? this.types,
        captured: captured ?? this.captured,
        generation: generation ?? this.generation,
        effectEntries: effectEntries ?? this.effectEntries,
        order: order.present ? order.value : this.order,
        userId: userId.present ? userId.value : this.userId,
      );
  PokemonData copyWithCompanion(PokemonCompanion data) {
    return PokemonData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      types: data.types.present ? data.types.value : this.types,
      captured: data.captured.present ? data.captured.value : this.captured,
      generation:
          data.generation.present ? data.generation.value : this.generation,
      effectEntries: data.effectEntries.present
          ? data.effectEntries.value
          : this.effectEntries,
      order: data.order.present ? data.order.value : this.order,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('types: $types, ')
          ..write('captured: $captured, ')
          ..write('generation: $generation, ')
          ..write('effectEntries: $effectEntries, ')
          ..write('order: $order, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, imageUrl, types, captured,
      generation, effectEntries, order, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonData &&
          other.id == this.id &&
          other.name == this.name &&
          other.imageUrl == this.imageUrl &&
          other.types == this.types &&
          other.captured == this.captured &&
          other.generation == this.generation &&
          other.effectEntries == this.effectEntries &&
          other.order == this.order &&
          other.userId == this.userId);
}

class PokemonCompanion extends UpdateCompanion<PokemonData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> imageUrl;
  final Value<String> types;
  final Value<bool> captured;
  final Value<String> generation;
  final Value<String> effectEntries;
  final Value<int?> order;
  final Value<int?> userId;
  const PokemonCompanion({
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
  PokemonCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String imageUrl,
    required String types,
    this.captured = const Value.absent(),
    required String generation,
    required String effectEntries,
    this.order = const Value.absent(),
    this.userId = const Value.absent(),
  })  : name = Value(name),
        imageUrl = Value(imageUrl),
        types = Value(types),
        generation = Value(generation),
        effectEntries = Value(effectEntries);
  static Insertable<PokemonData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? imageUrl,
    Expression<String>? types,
    Expression<bool>? captured,
    Expression<String>? generation,
    Expression<String>? effectEntries,
    Expression<int>? order,
    Expression<int>? userId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imageUrl != null) 'image_url': imageUrl,
      if (types != null) 'types': types,
      if (captured != null) 'captured': captured,
      if (generation != null) 'generation': generation,
      if (effectEntries != null) 'effect_entries': effectEntries,
      if (order != null) 'order': order,
      if (userId != null) 'user_id': userId,
    });
  }

  PokemonCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? imageUrl,
      Value<String>? types,
      Value<bool>? captured,
      Value<String>? generation,
      Value<String>? effectEntries,
      Value<int?>? order,
      Value<int?>? userId}) {
    return PokemonCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      types: types ?? this.types,
      captured: captured ?? this.captured,
      generation: generation ?? this.generation,
      effectEntries: effectEntries ?? this.effectEntries,
      order: order ?? this.order,
      userId: userId ?? this.userId,
    );
  }

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
      map['order'] = Variable<int>(order.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('types: $types, ')
          ..write('captured: $captured, ')
          ..write('generation: $generation, ')
          ..write('effectEntries: $effectEntries, ')
          ..write('order: $order, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $PokemonTable pokemon = $PokemonTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users, pokemon];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String username,
  required String password,
  Value<bool> isLoggedIn,
  Value<DateTime?> lastLogin,
  Value<String?> sessionToken,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> username,
  Value<String> password,
  Value<bool> isLoggedIn,
  Value<DateTime?> lastLogin,
  Value<String?> sessionToken,
});

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isLoggedIn => $composableBuilder(
      column: $table.isLoggedIn, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastLogin => $composableBuilder(
      column: $table.lastLogin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sessionToken => $composableBuilder(
      column: $table.sessionToken, builder: (column) => ColumnFilters(column));
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get password => $composableBuilder(
      column: $table.password, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isLoggedIn => $composableBuilder(
      column: $table.isLoggedIn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastLogin => $composableBuilder(
      column: $table.lastLogin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sessionToken => $composableBuilder(
      column: $table.sessionToken,
      builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<bool> get isLoggedIn => $composableBuilder(
      column: $table.isLoggedIn, builder: (column) => column);

  GeneratedColumn<DateTime> get lastLogin =>
      $composableBuilder(column: $table.lastLogin, builder: (column) => column);

  GeneratedColumn<String> get sessionToken => $composableBuilder(
      column: $table.sessionToken, builder: (column) => column);
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    UserData,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (UserData, BaseReferences<_$AppDatabase, $UsersTable, UserData>),
    UserData,
    PrefetchHooks Function()> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> password = const Value.absent(),
            Value<bool> isLoggedIn = const Value.absent(),
            Value<DateTime?> lastLogin = const Value.absent(),
            Value<String?> sessionToken = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            username: username,
            password: password,
            isLoggedIn: isLoggedIn,
            lastLogin: lastLogin,
            sessionToken: sessionToken,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String username,
            required String password,
            Value<bool> isLoggedIn = const Value.absent(),
            Value<DateTime?> lastLogin = const Value.absent(),
            Value<String?> sessionToken = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            username: username,
            password: password,
            isLoggedIn: isLoggedIn,
            lastLogin: lastLogin,
            sessionToken: sessionToken,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    UserData,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (UserData, BaseReferences<_$AppDatabase, $UsersTable, UserData>),
    UserData,
    PrefetchHooks Function()>;
typedef $$PokemonTableCreateCompanionBuilder = PokemonCompanion Function({
  Value<int> id,
  required String name,
  required String imageUrl,
  required String types,
  Value<bool> captured,
  required String generation,
  required String effectEntries,
  Value<int?> order,
  Value<int?> userId,
});
typedef $$PokemonTableUpdateCompanionBuilder = PokemonCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> imageUrl,
  Value<String> types,
  Value<bool> captured,
  Value<String> generation,
  Value<String> effectEntries,
  Value<int?> order,
  Value<int?> userId,
});

class $$PokemonTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonTable> {
  $$PokemonTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get types => $composableBuilder(
      column: $table.types, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get captured => $composableBuilder(
      column: $table.captured, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get generation => $composableBuilder(
      column: $table.generation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get effectEntries => $composableBuilder(
      column: $table.effectEntries, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));
}

class $$PokemonTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonTable> {
  $$PokemonTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get types => $composableBuilder(
      column: $table.types, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get captured => $composableBuilder(
      column: $table.captured, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get generation => $composableBuilder(
      column: $table.generation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get effectEntries => $composableBuilder(
      column: $table.effectEntries,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));
}

class $$PokemonTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonTable> {
  $$PokemonTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get types =>
      $composableBuilder(column: $table.types, builder: (column) => column);

  GeneratedColumn<bool> get captured =>
      $composableBuilder(column: $table.captured, builder: (column) => column);

  GeneratedColumn<String> get generation => $composableBuilder(
      column: $table.generation, builder: (column) => column);

  GeneratedColumn<String> get effectEntries => $composableBuilder(
      column: $table.effectEntries, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);
}

class $$PokemonTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PokemonTable,
    PokemonData,
    $$PokemonTableFilterComposer,
    $$PokemonTableOrderingComposer,
    $$PokemonTableAnnotationComposer,
    $$PokemonTableCreateCompanionBuilder,
    $$PokemonTableUpdateCompanionBuilder,
    (PokemonData, BaseReferences<_$AppDatabase, $PokemonTable, PokemonData>),
    PokemonData,
    PrefetchHooks Function()> {
  $$PokemonTableTableManager(_$AppDatabase db, $PokemonTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> imageUrl = const Value.absent(),
            Value<String> types = const Value.absent(),
            Value<bool> captured = const Value.absent(),
            Value<String> generation = const Value.absent(),
            Value<String> effectEntries = const Value.absent(),
            Value<int?> order = const Value.absent(),
            Value<int?> userId = const Value.absent(),
          }) =>
              PokemonCompanion(
            id: id,
            name: name,
            imageUrl: imageUrl,
            types: types,
            captured: captured,
            generation: generation,
            effectEntries: effectEntries,
            order: order,
            userId: userId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String imageUrl,
            required String types,
            Value<bool> captured = const Value.absent(),
            required String generation,
            required String effectEntries,
            Value<int?> order = const Value.absent(),
            Value<int?> userId = const Value.absent(),
          }) =>
              PokemonCompanion.insert(
            id: id,
            name: name,
            imageUrl: imageUrl,
            types: types,
            captured: captured,
            generation: generation,
            effectEntries: effectEntries,
            order: order,
            userId: userId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PokemonTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PokemonTable,
    PokemonData,
    $$PokemonTableFilterComposer,
    $$PokemonTableOrderingComposer,
    $$PokemonTableAnnotationComposer,
    $$PokemonTableCreateCompanionBuilder,
    $$PokemonTableUpdateCompanionBuilder,
    (PokemonData, BaseReferences<_$AppDatabase, $PokemonTable, PokemonData>),
    PokemonData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$PokemonTableTableManager get pokemon =>
      $$PokemonTableTableManager(_db, _db.pokemon);
}
