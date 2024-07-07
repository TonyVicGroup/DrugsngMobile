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

  const VerifyEmailOtpState(this.countdown, this.status);

  factory VerifyEmailOtpState.initial() =>
      const VerifyEmailOtpState(0, VerifyOtpStatus.waiting);

  @override
  List<Object?> get props => [countdown];
}
