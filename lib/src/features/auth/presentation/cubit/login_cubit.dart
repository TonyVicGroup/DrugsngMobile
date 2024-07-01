import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/tab_overlay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LoginState { initial, failed, loading, success }

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial);

  Future<void> login(String email, String password) async {
    emit(LoginState.loading);
    await Future.delayed(const Duration(seconds: 2));
    emit(LoginState.success);
    AppUtils.pushReplacement(const TabOverlay());
  }
}
