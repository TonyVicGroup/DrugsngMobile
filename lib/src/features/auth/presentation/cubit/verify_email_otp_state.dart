part of 'verify_email_otp_cubit.dart';

enum VerifyOtpStatus {
  active,
  waiting,
  loading,
  success,
  failed,
}

class VerifyEmailOtpState extends Equatable {
  final int countdown;
  final VerifyOtpStatus status;
  final String? message;

  const VerifyEmailOtpState(this.countdown, this.status, this.message);

  factory VerifyEmailOtpState.initial() =>
      const VerifyEmailOtpState(0, VerifyOtpStatus.waiting, null);

  @override
  List<Object?> get props => [countdown];
}
