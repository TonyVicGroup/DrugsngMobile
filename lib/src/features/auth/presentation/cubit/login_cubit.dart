import 'package:drugs_ng/src/core/enum/request_status.dart';
import 'package:drugs_ng/src/features/auth/domain/models/user.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthState {
  final Status status;

  AuthState([this.status = Status.initial]);
}

class LoggedInState extends AuthState {
  final User user;

  LoggedInState(this.user);
}

class LoggedOutState extends AuthState {
  LoggedOutState([super.status]);
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repo;

  AuthCubit(this.repo) : super(LoggedOutState());

  Future<void> login(String email, String password) async {
    emit(LoggedOutState(Status.loading));
    final result = await repo.login(email, password);
    result.fold(
      (left) => emit(LoggedOutState(Status.failed)),
      (user) => emit(LoggedInState(user)),
    );
  }
}
