import 'package:drugs_ng/core/enum/gender_enum.dart';

class SignupData {
  final String firstName, lastName;
  final String email;
  final String password;
  final bool getWeeklyUpdates;

  const SignupData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.getWeeklyUpdates,
  });
}

class AuthUserProfile {
  final String? firstName, lastName;
  final String email;
  final String? phone;
  final DateTime birthday;
  final GenderEnum gender;

  const AuthUserProfile({
    this.firstName,
    this.lastName,
    this.phone,
    required this.email,
    required this.birthday,
    required this.gender,
  });

  Map<String, dynamic> toMap() => {
    if (firstName != null) "FirstName": firstName,
    if (lastName != null) "LastName": lastName,
    if (phone != null) "Phone": phone,
    "Gender": gender.id,
    "Email": email,
    "DOB": birthday.toIso8601String().substring(0, 10),
  };
}
