class UserModel {
  final int id;
  final String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }
}

class AuthResponse {
  final String token;
  final String role;
  final UserModel? user;

  AuthResponse({required this.token, required this.role, this.user});

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    final token = map['token'] ?? map['access_token'] ?? map['data']?['token'];
    final role = map['role'] ?? map['data']?['role'] ?? 'user';
    final user = map['user'] != null ? UserModel.fromMap(map['user']) : null;

    return AuthResponse(
      token: token.toString(),
      role: role.toString(),
      user: user,
    );
  }
}
