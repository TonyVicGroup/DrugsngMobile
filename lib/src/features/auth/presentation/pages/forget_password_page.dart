import 'package:drugs_ng/src/core/enum/button_status.dart';
import 'package:drugs_ng/src/core/ui/app_toast.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/ui/app_text_field.dart';
import 'package:drugs_ng/src/core/utils/app_validators.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:drugs_ng/src/features/auth/presentation/cubit/forget_password_cubit.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/email_otp_page.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/reset_password_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final emailCntrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(context.read<AuthRepository>()),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccess) {
            Navigator.push(
              context,
              AppUtils.transition(EmailOtpPage(
                email: emailCntrl.text,
                handler: EmailOtpHandler(
                  onSuccess: (otp) {
                    Navigator.push(
                      context,
                      AppUtils.transition(ResetPasswordPage(otp: otp)),
                    );
                  },
                  onResendOtp: (bloc) {
                    bloc.resendPasswordResetOtp(emailCntrl.text);
                  },
                  onVerifyOtp: (otp, bloc) {
                    bloc.verifyPasswordResetOTP(otp);
                  },
                ),
              )),
            );
          } else if (state is ForgetPasswordError) {
            AppToast.warning(context, state.error.message);
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    64.verticalSpace,
                    AppButton.roundedBack(_back),
                    45.verticalSpace,
                    AppText.sp30("Forgot password?").w800.black,
                    13.verticalSpace,
                    AppText.sp16(
                            "Don't worry! It happens. Please enter the email associated with your account.")
                        .w400
                        .darkGrey,
                    30.verticalSpace,
                    AppText.sp14("Email address").w400.black,
                    6.verticalSpace,
                    AppTextField.text(
                      controller: emailCntrl,
                      keyboardType: TextInputType.text,
                      hint: "Enter your email address",
                      validator: AppValidators.email,
                    ),
                    40.verticalSpace,
                    AppButton.primary(
                      text: "Send code",
                      onTap: () => _sendCode(context),
                      status: state is ForgetPasswordLoading
                          ? ButtonStatus.loading
                          : ButtonStatus.active,
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "Remember password? ",
                          children: [
                            TextSpan(
                              text: " Log in",
                              style: TextStyle(
                                color: AppColor.primary,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _login,
                            ),
                          ],
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColor.darkGrey,
                            fontFamily: AppText.fontFamily,
                            height: 1.25,
                          ),
                        ),
                      ),
                    ),
                    54.verticalSpace,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _back() {
    Navigator.of(context).pop();
  }

  void _sendCode(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.read<ForgetPasswordCubit>().sendPasswordReset(emailCntrl.text);
    }
  }

  void _login() {
    Navigator.of(context).pop();
  }
}
