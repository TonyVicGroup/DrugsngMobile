import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/auth/data/repositories/auth_repository.dart';
import 'package:drugs_ng/features/auth/domain/models/auth_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository repo = AuthRepository();

  SignupCubit() : super(SignupState());

  Future createAccount(SignupData data) async {
    emit(state.copyWith(status: LoadStatusEnum.loading));
    final result = await repo.signup(data);
    result.fold(
      (left) => emit(state.copyWith(error: left)),
      (right) => emit(state.copyWith(status: LoadStatusEnum.success)),
    );
  }
}

class SignupState extends Equatable {
  const SignupState({this.status = LoadStatusEnum.initial, this.error});
  final LoadStatusEnum status;
  final AppError? error;

  SignupState copyWith({LoadStatusEnum? status, AppError? error}) {
    return SignupState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
