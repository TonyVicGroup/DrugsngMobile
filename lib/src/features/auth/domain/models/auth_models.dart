class SignupData {
  final String email;
  final String password;
  final bool getWeeklyUpdates;

  const SignupData({
    required this.email,
    required this.password,
    required this.getWeeklyUpdates,
  });
}

class AuthUserProfile {
  final String firstName, lastName;
  final SignupData data;
  final DateTime birthday;
  final bool gender;

  const AuthUserProfile({
    required this.firstName,
    required this.lastName,
    required this.data,
    required this.birthday,
    required this.gender,
  });

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "emailAddress": data.email,
        "password": data.password,
        "confirmPassword": data.password,
      };
}

class SetNewPasswordData {
  final String newPassword, token, userId;

  SetNewPasswordData({
    required this.newPassword,
    required this.token,
    required this.userId,
  });

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "newPassword": newPassword,
        "confirmPassword": newPassword,
        "token": token,
      };
}
