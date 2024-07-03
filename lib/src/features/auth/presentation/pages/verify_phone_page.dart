import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/create_account_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPhonePage extends StatelessWidget {
  const VerifyPhonePage({super.key});

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
            AppText.sp30("Verify your phone number").w800.black,
            13.verticalSpace,
            RichText(
              text: TextSpan(
                text:
                    "We've sent an SMS with an activation code to your phone ",
                children: [
                  TextSpan(
                    text: "+234 817 437 6390",
                    style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.w500,
                    ),
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
              length: 5,
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
                  inactiveColor: AppColor.lightGrey),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  text: "I didn't receive a code ",
                  children: [
                    TextSpan(
                      text: " Resend",
                      style: TextStyle(
                        color: AppColor.primary,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = _resend,
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
            40.verticalSpace,
            AppButton.primary(text: "Verify", onTap: _verify),
            54.verticalSpace,
          ],
        ),
      ),
    );
  }

  void _back() {
    AppUtils.pop();
  }

  void _verify() {
    AppUtils.push(const CreateAccountPage());
  }

  void _resend() {}
}
