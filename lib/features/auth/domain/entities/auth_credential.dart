import 'package:equatable/equatable.dart';

class AuthCredential extends Equatable {
  final String name;
  final String password;

  const AuthCredential({required this.name, required this.password});

  @override
  List<Object?> get props => [name, password];
}
