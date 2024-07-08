import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:drugs_ng/src/core/enum/request_status.dart';
import 'package:drugs_ng/src/features/auth/domain/models/user.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

abstract class AuthState {
  final Status status;

  AuthState([this.status = Status.initial]);
}

class LoggedInState extends AuthState {
  final User user;

  LoggedInState(this.user);
}

class LoggedOutState extends AuthState {
  final AppError? error;
  LoggedOutState([super.status, this.error]);
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repo;

  AuthCubit(this.repo) : super(LoggedOutState());

  Future<void> login(String email, String password) async {
    emit(LoggedOutState(Status.loading));
    if (await acceptPermission()) {
      final result = await repo.login(email, password);
      if (result.isRight) {
        await acceptPermission();
        emit(LoggedInState(result.right));
      } else {
        emit(LoggedOutState(Status.failed, result.left));
      }
    } else {
      emit(
        LoggedOutState(
          Status.failed,
          const AppError("location permission required"),
        ),
      );
    }
  }

  Future<bool> acceptPermission() async {
    final location = Location();
    final permission = await location.requestPermission();
    return permission != PermissionStatus.denied;
  }
}
