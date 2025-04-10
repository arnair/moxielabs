import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_pokedex/local_db/app_local_database.dart' as db;
import 'package:flutter_pokedex/features/authentication/domain/user_model.dart';

part 'auth_repository_local.g.dart';

class AuthRepositoryLocal {
  final db.AppDatabase _db;

  AuthRepositoryLocal(this._db);

  Future<User?> getUserByUsername(String username) async {
    final user = await _db.getUserByUsername(username);
    if (user == null) return null;

    return User(
      id: user.id,
      username: user.username,
      password: user.password,
      isLoggedIn: user.isLoggedIn,
      lastLogin: user.lastLogin,
      sessionToken: user.sessionToken,
    );
  }

  Future<User> createUser(String username, String password) async {
    final id = await _db.createUser(username, password);
    return User(
      id: id,
      username: username,
      password: password,
      isLoggedIn: false,
    );
  }

  Future<void> updateUser(User user) async {
    await _db.updateUser(
      user.id,
      user.username,
      user.password,
      user.isLoggedIn,
      user.lastLogin,
      user.sessionToken,
    );
  }

  Future<User?> getLoggedInUser() async {
    final user = await _db.getLoggedInUser();
    if (user == null) return null;

    return User(
      id: user.id,
      username: user.username,
      password: user.password,
      isLoggedIn: user.isLoggedIn,
      lastLogin: user.lastLogin,
      sessionToken: user.sessionToken,
    );
  }
}

@riverpod
AuthRepositoryLocal authRepositoryLocal(AuthRepositoryLocalRef ref) {
  final database = ref.watch(db.appDatabaseProvider);
  return AuthRepositoryLocal(database);
}
