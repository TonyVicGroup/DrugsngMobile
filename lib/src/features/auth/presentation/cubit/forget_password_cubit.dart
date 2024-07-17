import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepository repo;

  ForgetPasswordCubit(this.repo) : super(ForgetPasswordInitial());

  Future<void> sendPasswordReset(String email) async {
    emit(ForgetPasswordLoading());
    final result = await repo.sendPasswordReset(email);
    result.fold(
      (left) => emit(ForgetPasswordError(left)),
      (right) => emit(ForgetPasswordSuccess()),
    );
  }
}
