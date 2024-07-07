import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ForgetPasswordState { initial, failed, loading, success }

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepository repo;

  ForgetPasswordCubit(this.repo) : super(ForgetPasswordState.initial);

  Future<void> sendPasswordReset(String email) async {
    emit(ForgetPasswordState.loading);
    // final result = await repo.sendPasswordReset(email);
    // result.fold(
    //   (left) => emit(ForgetPasswordState.failed),
    //   (right) {
    //     emit(ForgetPasswordState.success);
    //   },
    // );
    await Future.delayed(const Duration(seconds: 1));
    emit(ForgetPasswordState.success);
  }
}
