import 'package:drugs_ng/src/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ResetPasswordState { initial, failed, loading, success }

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository repo;

  ResetPasswordCubit(this.repo) : super(ResetPasswordState.initial);

  Future<void> resetPassword(SetNewPasswordData data) async {
    emit(ResetPasswordState.loading);
    final result = await repo.setNewPassword(data);
    result.fold(
      (left) => emit(ResetPasswordState.failed),
      (right) {
        emit(ResetPasswordState.success);
      },
    );
  }
}
