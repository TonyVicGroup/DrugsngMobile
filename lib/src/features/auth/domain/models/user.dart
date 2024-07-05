class User {
  final int id;
  final String email, authToken, refreshToken, accountStatus, accountType;
  final bool isEmailConfirmed, isPhoneConfirmed;
  final List<String> permissions;

  User({
    required this.id,
    required this.email,
    required this.authToken,
    required this.refreshToken,
    required this.accountStatus,
    required this.accountType,
    required this.isEmailConfirmed,
    required this.isPhoneConfirmed,
    required this.permissions,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      authToken: map['authToken'],
      refreshToken: map['refreshToken'],
      accountStatus: map['accountStatus'],
      accountType: map['accountType'],
      isEmailConfirmed: map['isEmailConfirmed'],
      isPhoneConfirmed: map['isPhoneConfirmed'],
      permissions: map['permissions'],
    );
  }
}
