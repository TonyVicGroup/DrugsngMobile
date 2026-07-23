part of 'verify_email_otp_cubit.dart';

class EmailOtpState extends Equatable {
  final int countdown;
  final LoadStatusEnum status;
  final LoadStatusEnum resendStatus;
  final AppError? error;

  const EmailOtpState(
    this.countdown,
    this.status,
    this.resendStatus,
    this.error,
  );

  factory EmailOtpState.initial() => const EmailOtpState(
    0,
    LoadStatusEnum.initial,
    LoadStatusEnum.initial,
    null,
  );

  EmailOtpState copyWith({
    int? countdown,
    LoadStatusEnum? status,
    LoadStatusEnum? resendStatus,
    AppError? error,
  }) {
    return EmailOtpState(
      countdown ?? this.countdown,
      status ?? this.status,
      resendStatus ?? this.resendStatus,
      error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [countdown, status, resendStatus, error];
}
