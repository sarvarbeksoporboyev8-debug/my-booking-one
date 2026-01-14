class User {
  final String? id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String? passportNumber;
  final String? accessToken;
  final String? refreshToken;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    this.passportNumber,
    this.accessToken,
    this.refreshToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      passportNumber: json['passportNumber'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'passportNumber': passportNumber,
    };
  }
}

class AuthToken {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String? scope;

  AuthToken({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    this.scope,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? 'Bearer',
      expiresIn: json['expires_in'] ?? 3600,
      scope: json['scope'],
    );
  }
}
