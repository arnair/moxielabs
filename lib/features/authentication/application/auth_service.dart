import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/features/authentication/data/auth_repository_local.dart';
import 'package:flutter_pokedex/features/authentication/domain/user_model.dart';

part 'auth_service.g.dart';

class AuthService {
  final AuthRepositoryLocal _repository;

  AuthService(this._repository);

  Future<User?> login(String username, String password) async {
    final user = await _repository.getUserByUsername(username);
    if (user == null || user.password != password) {
      return null;
    }

    final updatedUser = user.copyWith(
      isLoggedIn: true,
      lastLogin: DateTime.now(),
    );
    await _repository.updateUser(updatedUser);
    return updatedUser;
  }

  Future<User> register(String username, String password) async {
    return await _repository.createUser(username, password);
  }

  Future<void> logout(User user) async {
    final updatedUser = user.copyWith(
      isLoggedIn: false,
      sessionToken: null,
    );
    await _repository.updateUser(updatedUser);
  }

  Future<User?> checkLoggedInUser() async {
    return await _repository.getLoggedInUser();
  }
}

@riverpod
AuthService authService(Ref ref) {
  final repository = ref.watch(authRepositoryLocalProvider);
  return AuthService(repository);
}
