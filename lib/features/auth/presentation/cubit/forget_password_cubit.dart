import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/core/enum/otp_type_enum.dart';
import 'package:drugs_ng/features/auth/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepository repo = AuthRepository();

  ForgetPasswordCubit() : super(ForgetPasswordState());

  void onEmailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void onObscurePasswordChanged(bool value) {
    emit(state.copyWith(obscurePassword: value));
  }

  Future<void> sendPasswordReset(String email) async {
    emit(state.copyWith(sendResetStatus: LoadStatusEnum.loading));
    final result = await repo.sendPasswordReset(state.email);
    result.fold(
      (left) => emit(
        state.copyWith(sendResetStatus: LoadStatusEnum.failed, error: left),
      ),
      (right) => emit(
        state.copyWith(sendResetStatus: LoadStatusEnum.success, email: email),
      ),
    );
  }

  Future<void> confirmOtp(String otp) async {
    emit(state.copyWith(confirmOtpStatus: LoadStatusEnum.loading));
    final result = await repo.verifyPasswordResetOTP(
      otp,
      // email: state.email,
      // otp: state.otp,
      // type: OtpTypeEnum.passwordReset,
    );
    result.fold(
      (left) => emit(
        state.copyWith(confirmOtpStatus: LoadStatusEnum.failed, error: left),
      ),
      (right) => emit(state.copyWith(confirmOtpStatus: LoadStatusEnum.success)),
    );
  }

  Future<void> resendOtp() async {
    emit(state.copyWith(resendOtpStatus: LoadStatusEnum.loading));
    final result = await repo.resendOtp(state.email, OtpTypeEnum.passwordReset);
    result.fold(
      (left) => emit(
        state.copyWith(resendOtpStatus: LoadStatusEnum.failed, error: left),
      ),
      (right) => emit(state.copyWith(resendOtpStatus: LoadStatusEnum.success)),
    );
  }

  // Future<void> resetPassword(String password) async {
  //   emit(state.copyWith(resetPasswordStatus: LoadStatusEnum.loading));
  //   final result = await repo.resetPassword(state.email, password);
  //   result.fold(
  //     (left) => emit(
  //       state.copyWith(resetPasswordStatus: LoadStatusEnum.failed, error: left),
  //     ),
  //     (right) => emit(
  //       state.copyWith(
  //         resetPasswordStatus: LoadStatusEnum.success,
  //         email: email,
  //       ),
  //     ),
  //   );
  // }
}

class ForgetPasswordState extends Equatable {
  const ForgetPasswordState({
    this.email = "",
    this.obscurePassword = true,
    this.sendResetStatus = LoadStatusEnum.initial,
    this.confirmOtpStatus = LoadStatusEnum.initial,
    this.resendOtpStatus = LoadStatusEnum.initial,
    this.resetPasswordStatus = LoadStatusEnum.initial,
    this.error,
  });

  final LoadStatusEnum sendResetStatus;
  final LoadStatusEnum confirmOtpStatus;
  final LoadStatusEnum resendOtpStatus;
  final LoadStatusEnum resetPasswordStatus;
  final AppError? error;
  final String email;
  final bool obscurePassword;

  ForgetPasswordState copyWith({
    String? email,
    bool? obscurePassword,
    LoadStatusEnum? sendResetStatus,
    LoadStatusEnum? confirmOtpStatus,
    LoadStatusEnum? resendOtpStatus,
    LoadStatusEnum? resetPasswordStatus,
    AppError? error,
  }) {
    return ForgetPasswordState(
      email: email ?? this.email,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      sendResetStatus: sendResetStatus ?? this.sendResetStatus,
      confirmOtpStatus: confirmOtpStatus ?? this.confirmOtpStatus,
      resendOtpStatus: resendOtpStatus ?? this.resendOtpStatus,
      resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    email,
    obscurePassword,
    sendResetStatus,
    confirmOtpStatus,
    resendOtpStatus,
    resetPasswordStatus,
    error,
  ];
}
