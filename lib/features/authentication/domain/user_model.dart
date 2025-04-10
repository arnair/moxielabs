class User {
  final int id;
  final String username;
  final String password;
  final bool isLoggedIn;
  final DateTime? lastLogin;
  final String? sessionToken;

  User({
    required this.id,
    required this.username,
    required this.password,
    this.isLoggedIn = false,
    this.lastLogin,
    this.sessionToken,
  });

  User copyWith({
    int? id,
    String? username,
    String? password,
    bool? isLoggedIn,
    DateTime? lastLogin,
    String? sessionToken,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      lastLogin: lastLogin ?? this.lastLogin,
      sessionToken: sessionToken ?? this.sessionToken,
    );
  }
}
