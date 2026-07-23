enum OtpTypeEnum {
  emailConfirmation(1),
  passwordReset(2),
  loginConfirmation(3);

  const OtpTypeEnum(this.value);
  final int value;

  bool get isEmailConfirmation => this == OtpTypeEnum.emailConfirmation;
  bool get isPasswordReset => this == OtpTypeEnum.passwordReset;
  bool get isLoginConfirmation => this == OtpTypeEnum.loginConfirmation;
}
