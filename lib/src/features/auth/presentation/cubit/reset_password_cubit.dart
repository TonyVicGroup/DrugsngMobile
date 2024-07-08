import 'package:drugs_ng/src/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository repo;

  ResetPasswordCubit(this.repo) : super(ResetPasswordInitial());

  Future<void> resetPassword(SetNewPasswordData data) async {
    emit(ResetPasswordLoading());
    final result = await repo.setNewPassword(data);
    result.fold(
      (left) => emit(ResetPasswordError(left.message)),
      (right) {
        emit(ResetPasswordSuccess());
      },
    );
  }
}
