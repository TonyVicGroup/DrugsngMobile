import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/features/auth/data/repositories/auth_repository.dart';
import 'package:drugs_ng/features/auth/domain/models/auth_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository repo = AuthRepository();

  SignupCubit() : super(SignupStateInitial());

  Future createAccount(SignupData data) async {
    emit(SignupStateLoading());
    final result = await repo.signup(data);
    result.fold(
      (left) => emit(SignupStateError(left)),
      (right) => emit(SignupStateSuccess()),
    );
  }
}
