import 'package:flutter_pokedex/local_db/app_local_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';

// Database provider
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

// Current user provider
final currentUserProvider = StateProvider<User?>((ref) => null);

// Login controller
class LoginController extends StateNotifier<AsyncValue<void>> {
  final AppDatabase _database;
  final StateController<User?> _userController;

  LoginController(this._database, this._userController)
      : super(const AsyncData(null));

  // Register a new user
  Future<bool> register(String username, String password) async {
    try {
      // Check if username already exists
      final existingUser = await _database.getUserByUsername(username);
      if (existingUser != null) {
        return false;
      }

      // Create a new user
      await _database.createUser(
        UsersCompanion.insert(
          username: username,
          password: password,
          isLoggedIn: const Value(true),
        ),
      );

      // Get the created user
      final newUser = await _database.getUserByUsername(username);
      if (newUser != null) {
        _userController.state = newUser;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Login an existing user
  Future<bool> login(String username, String password) async {
    try {
      final user = await _database.getUserByUsername(username);
      if (user != null && user.password == password) {
        await _database.updateUserLoginStatus(user.id, true);
        _userController.state = user;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Logout the current user
  Future<void> logout() async {
    final currentUser = _userController.state;
    if (currentUser != null) {
      await _database.updateUserLoginStatus(currentUser.id, false);
      _userController.state = null;
    }
  }

  // Check if a user is already logged in
  Future<bool> checkLoggedInUser() async {
    try {
      final users = await _database.select(_database.users).get();
      final loggedInUser = users.where((user) => user.isLoggedIn).firstOrNull;

      if (loggedInUser != null) {
        _userController.state = loggedInUser;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

// Login controller provider
final loginControllerProvider =
    StateNotifierProvider<LoginController, AsyncValue<void>>((ref) {
  final database = ref.watch(databaseProvider);
  final userController = ref.watch(currentUserProvider.notifier);
  return LoginController(database, userController);
});
