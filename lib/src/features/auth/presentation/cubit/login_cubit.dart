import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository repo;

  LoginCubit(this.repo) : super(LoginStateInitial());

  Future<void> login(String email, String password) async {
    emit(LoginStateLoading());
    final result = await repo.login(email, password);
    result.fold(
      (left) => emit(LoginStateError(left.message)),
      (right) {
        emit(LoginStateSuccess());
      },
    );
  }
}
