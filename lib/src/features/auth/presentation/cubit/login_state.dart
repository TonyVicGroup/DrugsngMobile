part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginStateInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateError extends LoginState {
  final String message;

  const LoginStateError(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginStateSuccess extends LoginState {}
