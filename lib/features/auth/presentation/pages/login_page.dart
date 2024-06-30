import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/extensions/widget_extension.dart';
import 'package:drugs_ng/core/ui/app_button.dart';
import 'package:drugs_ng/core/ui/app_text.dart';
import 'package:drugs_ng/core/ui/app_text_field.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/core/utils/app_validators.dart';
import 'package:drugs_ng/features/auth/presentation/pages/enter_phone_page.dart';
import 'package:drugs_ng/features/auth/presentation/pages/forget_password_page.dart';
import 'package:drugs_ng/src/tab_overlay.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController loginCntrl = TextEditingController();
  TextEditingController passwordCntrl = TextEditingController();
  bool obscurePassword = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    loginCntrl.dispose();
    passwordCntrl.dispose();
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
              148.verticalSpace,
              AppText.sp30("Log in").w800.black,
              13.verticalSpace,
              AppText.sp16("Welcome back!").w400.darkGrey,
              30.verticalSpace,
              AppText.sp14("Email").w400.black,
              6.verticalSpace,
              AppTextField.text(
                controller: loginCntrl,
                keyboardType: TextInputType.text,
                hint: "Your Email",
                validator: AppValidators.email,
              ),
              22.verticalSpace,
              AppText.sp14("Password").w400.black,
              6.verticalSpace,
              AppTextField.text(
                controller: passwordCntrl,
                keyboardType: TextInputType.text,
                suffixIcon: svgPicture(),
                obscureText: obscurePassword,
                clickSuffix: _toggleVisibility,
                validator: AppValidators.password,
              ),
              15.verticalSpace,
              Align(
                alignment: Alignment.centerRight,
                child: AppText.sp14("Forgot password?")
                    .black
                    .w400
                    .clickable(_forgetPassword),
              ),
              40.verticalSpace,
              AppButton.primary(text: "Log in", onTap: _login),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    children: [
                      TextSpan(
                        text: " Sign up",
                        style: TextStyle(
                          color: AppColor.primary,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = _signup,
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

  Widget svgPicture() => SvgPicture.asset(
        obscurePassword ? AppSvg.visible : AppSvg.notVisible,
        width: 17.w,
        colorFilter: const ColorFilter.mode(
          AppColor.darkGrey,
          BlendMode.srcIn,
        ),
      );

  void _toggleVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void _forgetPassword() {
    AppUtils.push(const ForgetPasswordPage());
  }

  void _login() {
    if (formKey.currentState?.validate() ?? false) {
      AppUtils.pushReplacement(const TabOverlay());
    }
  }

  void _signup() {
    AppUtils.push(const EnterPhonePage());
  }
}
