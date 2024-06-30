part of 'session_cubit.dart';

sealed class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

class Unauthenticated extends SessionState {}

class Authenticated extends SessionState {
  final UserData user;

  const Authenticated({required this.user});
}
