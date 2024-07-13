import 'package:drugs_ng/src/core/enum/button_status.dart';
import 'package:drugs_ng/src/core/ui/app_toast.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:drugs_ng/src/features/auth/presentation/cubit/verify_email_otp_cubit.dart';
import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailOtpHandler {
  final String email;
  final void Function(EmailOtpCubit)? onResendOtp;
  final void Function(String otp, EmailOtpCubit) onVerifyOtp;
  final void Function(String otp) onSuccess;

  EmailOtpHandler({
    required this.email,
    required this.onSuccess,
    required this.onVerifyOtp,
    this.onResendOtp,
  });
}

class EmailOtpPage extends StatefulWidget {
  final EmailOtpHandler handler;

  const EmailOtpPage({super.key, required this.handler});

  @override
  State<EmailOtpPage> createState() => _EmailOtpPageState();
}

class _EmailOtpPageState extends State<EmailOtpPage> {
  String code = "";

  // CountdownTimerController? timerController;

  @override
  void initState() {
    // _setupTimer();
    super.initState();
  }

  // void _setupTimer() {
  //   timerController?.dispose();
  //   timerController = CountdownTimerController(
  //     endTime: DateTime.now().millisecondsSinceEpoch + 60000,
  //   )..start();
  // }

  @override
  void dispose() {
    // timerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resendCodeTextStyle = TextStyle(
      fontSize: 16.sp,
      height: 1.25,
      fontWeight: FontWeight.w800,
      fontFamily: AppText.fontFamily,
    );
    return BlocProvider(
      create: (context) {
        return EmailOtpCubit(context.read<AuthRepository>())..startTimer(60);
      },
      child: BlocConsumer<EmailOtpCubit, EmailOtpState>(
        listener: (context, state) {
          if (state.status == VerifyOtpStatus.success) {
            widget.handler.onSuccess(code);
            // Navigator.push(
            //   context,
            //   AppUtils.transition(ResetPasswordPage(otp: code)),
            // );
          } else if (state.status == VerifyOtpStatus.failed &&
              state.error != null) {
            AppToast.warning(context, state.error!.message);
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
                  AppButton.roundedBack(Navigator.of(context).pop),
                  45.verticalSpace,
                  AppText.sp30("Please check your email").w800.black,
                  13.verticalSpace,
                  RichText(
                    text: TextSpan(
                      text: "We've sent a code to ",
                      children: [
                        TextSpan(
                          text: widget.handler.email,
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
                    onChanged: (pin) => setState(() => code = pin),
                  ),
                  20.verticalSpace,
                  AppButton.primary(
                    text: "Verify",
                    onTap: () {
                      widget.handler.onVerifyOtp(code, context.read());
                    },
                    status: code.length < 4
                        ? ButtonStatus.disabled
                        : state.status == VerifyOtpStatus.loading
                            ? ButtonStatus.loading
                            : ButtonStatus.active,
                  ),
                  40.verticalSpace,
                  if (widget.handler.onResendOtp != null)
                    Align(
                      alignment: Alignment.center,
                      child: Builder(builder: (context) {
                        if (state.countdown <= 0) {
                          return GestureDetector(
                            onTap: () {
                              widget.handler.onResendOtp!(context.read());
                            },
                            child: Text(
                              'Send code again',
                              style: resendCodeTextStyle,
                            ),
                          );
                        }

                        return RichText(
                          text: TextSpan(
                            text: "Send code again  ",
                            children: [
                              TextSpan(
                                text: _countdownText(state.countdown),
                                style: const TextStyle(
                                  color: AppColor.red,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                            style: resendCodeTextStyle.copyWith(
                              color: AppColor.lightGrey,
                            ),
                          ),
                        );
                      }),
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

  // void _verify(BuildContext context) {
  //   context.read<EmailOtpCubit>().verifyPasswordResetOTP(code);
  // }

  // void _resend(BuildContext context) {
  //   context.read<EmailOtpCubit>().resendOtp(widget.handler.email);
  // }

  String _countdownText(int countdown) {
    int seconds = countdown % 60;
    int minute = (countdown / 60).floor();
    String sec = "$seconds".padLeft(2, '0');
    String min = "$minute".padLeft(2, '0');
    return "$min:$sec";
  }
}
