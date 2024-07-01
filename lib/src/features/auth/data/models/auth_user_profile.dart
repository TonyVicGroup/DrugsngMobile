import 'package:equatable/equatable.dart';

class AuthUserProfile extends Equatable {
  final String firstName;
  final String lastName;
  final DateTime birthday;
  final bool gender;

  const AuthUserProfile({
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.gender,
  });

  AuthUserProfile copy({
    String? firstName,
    String? lastName,
    DateTime? birthday,
    bool? gender,
  }) =>
      AuthUserProfile(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        birthday: birthday ?? this.birthday,
        gender: gender ?? this.gender,
      );

  @override
  List<Object?> get props => [firstName, lastName, birthday, gender];
}
