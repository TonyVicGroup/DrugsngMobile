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
    final result = await repo.login(email, password);
    if (result.isRight) {
      emit(LoggedInState(result.right));
      await acceptPermission();
    } else {
      emit(LoggedOutState(Status.failed, result.left));
    }
  }

  Future<bool> acceptPermission() async {
    final location = Location();
    final permission = await location.requestPermission();
    // handle permision data
    return permission != PermissionStatus.denied;
  }
}
