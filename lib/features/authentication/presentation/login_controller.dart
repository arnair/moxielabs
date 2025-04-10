import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_pokedex/features/authentication/application/auth_service.dart';
import 'package:flutter_pokedex/features/authentication/domain/user_model.dart'
    as auth;

class LoginController extends StateNotifier<AsyncValue<void>> {
  final AuthService _service;
  auth.User? _currentUser;
  bool _isLoading = false;

  LoginController(this._service) : super(const AsyncValue.data(null));

  auth.User getCurrentUser() {
    return _currentUser!;
  }

  bool get isLoading => _isLoading;

  Future<bool> submit(String username, String password, bool isLogin) async {
    if (username.length < 3 || password.length < 6) {
      state = AsyncValue.error('Invalid credentials', StackTrace.current);
      return false;
    }

    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      final result = await (isLogin
          ? _service.login(username, password)
          : _service.register(username, password));

      if (result != null) {
        _currentUser = result;
        state = const AsyncValue.data(null);
        _isLoading = false;
        return true;
      }

      state = AsyncValue.error(
        isLogin
            ? 'Login failed. Please check your credentials.'
            : 'Registration failed. Username may already exist.',
        StackTrace.current,
      );
      _isLoading = false;
      return false;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      _isLoading = false;
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await _service.login(username, password);
      if (user != null) {
        _currentUser = user;
        state = const AsyncValue.data(null);
        return true;
      }
      state = AsyncValue.error('Invalid credentials', StackTrace.current);
      return false;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> register(String username, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await _service.register(username, password);
      _currentUser = user;
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<void> logout() async {
    if (_currentUser != null) {
      await _service.logout(_currentUser!);
      _currentUser = null;
    }
  }

  Future<bool> checkLoggedInUser() async {
    try {
      final user = await _service.checkLoggedInUser();
      if (user != null) {
        _currentUser = user;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, AsyncValue<void>>((ref) {
  final service = ref.watch(authServiceProvider);
  return LoginController(service);
});
