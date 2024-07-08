import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:drugs_ng/src/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/src/features/auth/domain/models/user.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository repo;

  SignupCubit(this.repo) : super(SignupStateInitial());

  Future createAccount(SignupData data) async {
    emit(SignupStateLoading());
    final result = await repo.signup(data);
    result.fold(
      (left) => emit(SignupStateError(left)),
      (right) {
        emit(SignupStateSuccess(right));
      },
    );
  }
}
