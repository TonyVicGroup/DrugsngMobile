class User {
  final int id;
  final String authToken, refreshToken;
  final bool isEmailConfirmed;
  UserData? data;

  User({
    required this.id,
    required this.authToken,
    required this.refreshToken,
    required this.isEmailConfirmed,
    this.data,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['userId'],
      authToken: map['jwtToken'],
      refreshToken: map['refreshToken'],
      isEmailConfirmed: map['isEmailConfirmed'],
    );
  }
}

class UserData {
  final int id;
  final String firstName, lastName;
  final String email;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
    );
  }
}
