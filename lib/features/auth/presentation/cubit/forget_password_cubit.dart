import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/features/auth/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepository repo = AuthRepository();

  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future<void> sendPasswordReset(String email) async {
    emit(ForgetPasswordLoading());
    final result = await repo.sendPasswordReset(email);
    result.fold(
      (left) => emit(ForgetPasswordError(left)),
      (right) => emit(ForgetPasswordSuccess()),
    );
  }
}
