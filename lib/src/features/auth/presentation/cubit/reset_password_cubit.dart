import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository repo;

  ResetPasswordCubit(this.repo) : super(ResetPasswordInitial());

  Future<void> resetPassword(String newPassword, String otp) async {
    emit(ResetPasswordLoading());
    final result = await repo.setNewPassword(newPassword, otp);
    result.fold(
      (left) => emit(ResetPasswordError(left)),
      (right) => emit(ResetPasswordSuccess()),
    );
  }
}
