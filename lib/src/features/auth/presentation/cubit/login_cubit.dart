import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/auth/data/repositories/auth_repository.dart';
import 'package:drugs_ng/src/tab_overlay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LoginState { initial, failed, loading, success }

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository repo;

  LoginCubit(this.repo) : super(LoginState.initial);

  Future<void> login(String email, String password) async {
    emit(LoginState.loading);
    final result = await repo.login(email: email, password: password);
    result.fold((left) {
      emit(LoginState.failed);
    }, (right) {
      emit(LoginState.success);
      AppUtils.pushReplacement(const TabOverlay());
    });
  }
}
