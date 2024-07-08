import 'package:drugs_ng/src/core/enum/button_status.dart';
import 'package:drugs_ng/src/core/ui/app_toast.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:drugs_ng/src/features/auth/presentation/cubit/verify_email_otp_cubit.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/reset_password_page.dart';
import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyEmailPage extends StatefulWidget {
  final String email;
  const VerifyEmailPage({super.key, required this.email});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  String code = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VerifyEmailOtpCubit(context.read<AuthRepository>())..startTimer(30),
      child: BlocConsumer<VerifyEmailOtpCubit, VerifyEmailOtpState>(
        listener: (context, state) {
          if (state.status == VerifyOtpStatus.success) {
            Navigator.push(
              context,
              AppUtils.transition(const ResetPasswordPage()),
            );
          } else if (state.status == VerifyOtpStatus.failed) {
            AppToast.warning(context, state.message ?? "");
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  64.verticalSpace,
                  AppButton.roundedBack(_back),
                  45.verticalSpace,
                  AppText.sp30("Please check your email").w800.black,
                  13.verticalSpace,
                  RichText(
                    text: TextSpan(
                      text: "We've sent a code to ",
                      children: [
                        TextSpan(
                          text: widget.email,
                          style: const TextStyle(color: AppColor.black),
                        ),
                      ],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.darkGrey,
                      ),
                    ),
                  ),
                  30.verticalSpace,
                  PinCodeTextField(
                    keyboardType: TextInputType.number,
                    appContext: context,
                    autoFocus: true,
                    length: 4,
                    textStyle: TextStyle(
                      fontSize: 24.sp,
                      color: AppColor.black,
                    ),
                    pinTheme: PinTheme(
                      selectedColor: AppColor.lightGrey,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(15.r),
                      fieldHeight: 64.h,
                      fieldWidth: 63.w,
                      activeColor: AppColor.lightGrey,
                      inactiveFillColor: AppColor.lightGrey,
                      activeFillColor: AppColor.lightGrey,
                      inactiveColor: AppColor.lightGrey,
                    ),
                    onChanged: (pin) {
                      code = pin;
                    },
                  ),
                  20.verticalSpace,
                  AppButton.primary(
                    text: "Verify",
                    onTap: () => _verify(context),
                    status: state.status == VerifyOtpStatus.loading
                        ? ButtonStatus.loading
                        : ButtonStatus.active,
                  ),
                  40.verticalSpace,
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: "Send code again  ",
                        children: [
                          TextSpan(
                            text: _countdownText(state.countdown),
                            style: TextStyle(
                              color: AppColor.red,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _resend(context),
                          ),
                        ],
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColor.darkGrey,
                          fontFamily: AppText.fontFamily,
                          height: 1.25,
                        ),
                      ),
                    ),
                  ),
                  40.verticalSpace,
                ],
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

  void _verify(BuildContext context) {
    AppUtils.pushWidget(const ResetPasswordPage());
  }

  void _resend(BuildContext context) {
    // if (context.read<VerifyEmailOtpCubit>().state.status !=
    //     VerifyOtpStatus.waiting) {
    context.read<VerifyEmailOtpCubit>().resendOtp(widget.email);
    // } else {
    //   // display cant resend data
    // }
  }

  String _countdownText(int countdown) {
    int seconds = countdown % 60;
    int minute = (countdown / 60).floor();
    String sec = "$seconds".padLeft(2, '0');
    String min = "$minute".padLeft(2, '0');
    return "$min:$sec";
  }
}
