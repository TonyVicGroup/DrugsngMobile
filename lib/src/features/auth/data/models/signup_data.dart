import 'package:equatable/equatable.dart';

class SignupData extends Equatable {
  final String email;
  final String password;
  final bool getWeeklyUpdates;

  const SignupData({
    required this.email,
    required this.password,
    required this.getWeeklyUpdates,
  });

  SignupData copy({
    String? email,
    String? password,
    bool? getWeeklyUpdates,
  }) =>
      SignupData(
        email: email ?? this.email,
        password: password ?? this.password,
        getWeeklyUpdates: getWeeklyUpdates ?? this.getWeeklyUpdates,
      );

  @override
  List<Object?> get props => [email, password, getWeeklyUpdates];
}
