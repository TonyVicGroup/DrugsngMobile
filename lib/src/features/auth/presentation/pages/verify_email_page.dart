import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/reset_password_page.dart';
import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  String code = "";

  CountdownTimerController? timerController;

  @override
  void initState() {
    _setupTimer();
    super.initState();
  }

  void _setupTimer() {
    timerController?.dispose();
    timerController = CountdownTimerController(
      endTime: DateTime.now().millisecondsSinceEpoch + 60000,
    )..start();
  }

  @override
  void dispose() {
    timerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                children: const [
                  TextSpan(
                    text: "example@email.com",
                    style: TextStyle(color: AppColor.black),
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
              onChanged: (pin) => code = pin,
            ),
            20.verticalSpace,
            AppButton.primary(text: "Verify", onTap: _verify),
            40.verticalSpace,
            CountdownTimer(
              key: ValueKey(timerController),
              controller: timerController,
              endWidget: Text(
                "Send code again",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColor.black,
                  fontFamily: AppText.fontFamily,
                  height: 1.25,
                ),
              ),
              widgetBuilder: (context, time) {
                return RichText(
                  text: TextSpan(
                    text: "Send code again  ",
                    children: [
                      TextSpan(
                        text: "00:20",
                        style: TextStyle(
                          color: AppColor.red,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = _resend,
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
                );
              },
            ),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }

  void _back() {
    Navigator.of(context).pop();
  }

  void _verify() {
    AppUtils.pushWidget(const ResetPasswordPage());
  }

  void _resend() {}
}
