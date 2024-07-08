part of 'signup_cubit.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object?> get props => [];
}

class SignupStateInitial extends SignupState {}

class SignupStateLoading extends SignupState {}

class SignupStateSuccess extends SignupState {
  final SignupData data;

  const SignupStateSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class SignupStateError extends SignupState {
  final String message;

  const SignupStateError(this.message);

  @override
  List<Object?> get props => [message];
}
