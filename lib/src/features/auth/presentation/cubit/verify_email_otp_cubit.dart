import 'dart:async';

import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_email_otp_state.dart';

class VerifyEmailOtpCubit extends Cubit<VerifyEmailOtpState> {
  final AuthRepository repo;
  Timer? _timer;

  VerifyEmailOtpCubit(this.repo) : super(VerifyEmailOtpState.initial());

  void startTimer(int seconds) {
    emit(VerifyEmailOtpState(seconds, VerifyOtpStatus.waiting, null));
    // Cancel any existing timer
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newTime = state.countdown - 1;

      if (newTime <= 0) {
        _timer?.cancel();
        emit(VerifyEmailOtpState(newTime, VerifyOtpStatus.active, null));
      } else {
        emit(VerifyEmailOtpState(newTime, VerifyOtpStatus.waiting, null));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  Future<void> sendPasswordReset(String otp) async {
    emit(VerifyEmailOtpState(state.countdown, VerifyOtpStatus.loading, null));
    final result = await repo.verifyPasswordResetOTP(otp);
    result.fold(
      (left) => emit(
          VerifyEmailOtpState(state.countdown, VerifyOtpStatus.failed, left)),
      (right) {
        emit(VerifyEmailOtpState(
            state.countdown, VerifyOtpStatus.success, null));
      },
    );
  }

  Future<void> resendOtp(String email, [int countdown = 30]) async {
    emit(VerifyEmailOtpState(state.countdown, VerifyOtpStatus.loading, null));
    final result = await repo.sendPasswordReset(email);
    result.fold(
      (left) => emit(
          VerifyEmailOtpState(state.countdown, VerifyOtpStatus.failed, left)),
      (right) {
        emit(VerifyEmailOtpState(
            state.countdown, VerifyOtpStatus.waiting, null));
        startTimer(countdown);
      },
    );
  }
}
