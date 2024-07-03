import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/ui/app_text_field.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/verify_phone_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnterPhonePage extends StatelessWidget {
  const EnterPhonePage({super.key});

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
            AppText.sp30("Enter your phone number").w800.black,
            13.verticalSpace,
            AppText.sp16(
                    "Please enter and verify your phone number to continue.")
                .w400
                .darkGrey,
            30.verticalSpace,
            AppText.sp14("Phone number").w400.black,
            6.verticalSpace,
            AppTextField.text(
              autofocus: true,
              keyboardType: TextInputType.number,
              prefix: AppText.sp16("+234 ").w400.darkGrey,
            ),
            const Spacer(),
            AppButton.primary(text: "Send OTP", onTap: _sendOTP),
            54.verticalSpace,
          ],
        ),
      ),
    );
  }

  void _back() {
    AppUtils.pop();
  }

  void _sendOTP() {
    AppUtils.push(const VerifyPhonePage());
  }
}
