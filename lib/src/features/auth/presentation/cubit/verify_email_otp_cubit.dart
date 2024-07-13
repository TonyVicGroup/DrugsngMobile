import 'dart:async';

import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_email_otp_state.dart';

class EmailOtpCubit extends Cubit<EmailOtpState> {
  final AuthRepository repo;
  Timer? _timer;

  EmailOtpCubit(this.repo) : super(EmailOtpState.initial());

  void startTimer([int seconds = 60]) {
    emit(state.copyWith(countdown: seconds, status: VerifyOtpStatus.waiting));
    // Cancel any existing timer
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newTime = state.countdown - 1;

      if (newTime <= 0) {
        _timer?.cancel();
        emit(state.copyWith(
          countdown: newTime,
          status: VerifyOtpStatus.active,
        ));
      } else {
        emit(state.copyWith(
          countdown: newTime,
          status: VerifyOtpStatus.active,
        ));
      }
    });
  }

  Future<void> verifyPasswordResetOTP(String otp) async {
    emit(state.copyWith(status: VerifyOtpStatus.loading));
    final result = await repo.verifyPasswordResetOTP(otp);
    result.fold(
      (left) {
        emit(state.copyWith(status: VerifyOtpStatus.failed, error: left));
      },
      (right) {
        emit(state.copyWith(status: VerifyOtpStatus.success));
      },
    );
  }

  Future<void> resendPasswordResetOtp(String email) async {
    emit(state.copyWith(status: VerifyOtpStatus.loading));
    final result = await repo.resendOtp(email, 2);
    result.fold(
      (left) {
        emit(state.copyWith(status: VerifyOtpStatus.failed, error: left));
      },
      (right) {
        emit(state.copyWith(status: VerifyOtpStatus.waiting));
        startTimer();
      },
    );
  }

  Future<void> resendAccountConfirmOtp(String email) async {
    emit(state.copyWith(status: VerifyOtpStatus.loading));
    final result = await repo.resendOtp(email, 1);
    result.fold(
      (left) {
        emit(state.copyWith(status: VerifyOtpStatus.failed, error: left));
      },
      (right) {
        emit(state.copyWith(status: VerifyOtpStatus.waiting));
        startTimer();
      },
    );
  }

  Future<void> verifyAccountConfirmOTP(String otp) async {
    emit(state.copyWith(status: VerifyOtpStatus.loading));
    final result = await repo.confirmAccount(otp);
    result.fold(
      (left) {
        emit(state.copyWith(status: VerifyOtpStatus.failed, error: left));
      },
      (right) {
        emit(state.copyWith(status: VerifyOtpStatus.success));
      },
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
