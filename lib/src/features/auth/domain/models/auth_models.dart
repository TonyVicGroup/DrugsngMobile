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
  final String email;
  final DateTime birthday;
  final bool gender;

  const AuthUserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthday,
    required this.gender,
  });

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender ? 'Male' : 'Female',
        "email": email,
        "dob": birthday.toIso8601String().substring(0, 10),
      };
}
