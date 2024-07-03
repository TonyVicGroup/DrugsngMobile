import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/ui/app_text_field.dart';
import 'package:drugs_ng/src/core/utils/app_validators.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/verify_email_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController emailCntrl = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              AppButton.primary(text: "Send code", onTap: _sendCode),
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
                        recognizer: TapGestureRecognizer()..onTap = _login,
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
  }

  void _back() {
    AppUtils.pop();
  }

  void _sendCode() {
    if (formKey.currentState?.validate() ?? false) {
      AppUtils.push(const VerifyEmailPage());
    }
  }

  void _login() {
    AppUtils.pop();
  }
}
