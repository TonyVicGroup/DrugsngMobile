import 'dart:async';

import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/core/enum/otp_type_enum.dart';
import 'package:drugs_ng/features/auth/data/repositories/auth_repository.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_email_otp_state.dart';

class EmailOtpCubit extends Cubit<EmailOtpState> {
  final AuthRepository repo = AuthRepository();
  final OtpTypeEnum otpType;
  final String email;
  Timer? _timer;

  EmailOtpCubit({required this.otpType, required this.email})
    : super(EmailOtpState.initial());

  void startTimer([int seconds = 60]) {
    emit(
      state.copyWith(countdown: seconds /* , status: LoadStatusEnum.loading */),
    );
    // Cancel any existing timer
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newTime = state.countdown - 1;

      if (newTime <= 0) {
        _timer?.cancel();
        emit(state.copyWith(countdown: newTime));
      } else {
        emit(state.copyWith(countdown: newTime));
      }
    });
  }

  Future<void> resendOtp() async {
    emit(
      state.copyWith(
        resendStatus: LoadStatusEnum.loading,
        status: LoadStatusEnum.initial,
      ),
    );
    final result = await repo.resendOtp(email, otpType);
    result.fold(
      (left) {
        emit(state.copyWith(resendStatus: LoadStatusEnum.failed, error: left));
      },
      (right) {
        emit(state.copyWith(resendStatus: LoadStatusEnum.success));
        startTimer();
      },
    );
  }

  Future<void> confirmOtp({String? password, required otp}) async {
    emit(
      state.copyWith(
        status: LoadStatusEnum.loading,
        resendStatus: LoadStatusEnum.initial, // Reset resend status
      ),
    );
    final Either<ApiError, void> result;
    if (otpType.isPasswordReset) {
      result = await repo.verifyPasswordResetOTP(otp);
    } else if (otpType.isEmailConfirmation) {
      result = await repo.confirmAccount(otp: otp, email: email);
    } else {
      throw UnimplementedError('OTP type not supported');
    }
    result.fold(
      (left) {
        emit(state.copyWith(status: LoadStatusEnum.failed, error: left));
      },
      (right) {
        emit(state.copyWith(status: LoadStatusEnum.success));
      },
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
