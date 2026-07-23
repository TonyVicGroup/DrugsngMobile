import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/auth/data/repositories/auth_repository.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository repo = AuthRepository();
  LoginCubit(this._authCubit) : super(LoginState());

  final AuthCubit _authCubit;

  Future<void> login(String email, String password) async {
    emit(LoginState(status: LoadStatusEnum.loading));
    final result = await repo.login(email, password);
    result.fold(
      (error) {
        emit(LoginState(error: error.message, status: LoadStatusEnum.failed));
      },
      (result) {
        _authCubit.getProfile(result);
        emit(LoginState(status: LoadStatusEnum.success));
      },
    );
  }
}

class LoginState extends Equatable {
  final String? error;
  final LoadStatusEnum status;

  const LoginState({this.error, this.status = LoadStatusEnum.initial});

  LoginState copyWith({String? error, LoadStatusEnum? status}) {
    return LoginState(
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [error, status];
}
