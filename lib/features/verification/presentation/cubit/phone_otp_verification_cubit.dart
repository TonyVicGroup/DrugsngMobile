import 'dart:async';

import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneOtpVerificationCubit extends Cubit<PhoneOtpVerificationState> {
  PhoneOtpVerificationCubit() : super(const PhoneOtpVerificationState());

  Timer? _timer;

  void startTimer([int seconds = 60]) {
    emit(state.copyWith(countdown: seconds));
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
}

class PhoneOtpVerificationState extends Equatable {
  final LoadStatusEnum verifyStatus;
  final LoadStatusEnum resendStatus;
  final int countdown;

  const PhoneOtpVerificationState({
    this.resendStatus = LoadStatusEnum.initial,
    this.verifyStatus = LoadStatusEnum.initial,
    this.countdown = 60,
  });

  PhoneOtpVerificationState copyWith({
    LoadStatusEnum? verifyStatus,
    LoadStatusEnum? resendStatus,
    int? countdown,
  }) {
    return PhoneOtpVerificationState(
      verifyStatus: verifyStatus ?? this.verifyStatus,
      resendStatus: resendStatus ?? this.resendStatus,
      countdown: countdown ?? this.countdown,
    );
  }

  @override
  List<Object?> get props => [verifyStatus, resendStatus, countdown];
}
