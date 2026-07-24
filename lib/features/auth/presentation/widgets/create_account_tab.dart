import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/navigation/app_route.dart';
import 'package:drugs_ng/core/utils/app_validators.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/textfield/border_text_field.dart';
import 'package:drugs_ng/features/auth/presentation/widgets/privacy_policy_widget.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';

class CreateAccountTab extends StatelessWidget {
  const CreateAccountTab({
    super.key,
    required this.controller,
    required this.email,
    required this.password1,
    required this.password2,
    required this.formKey,
    required this.obscurePassword1,
    required this.obscurePassword2,
    required this.acceptTerms,
    required this.acceptTermsHasError,
  });

  final PageController controller;
  final TextEditingController email;
  final TextEditingController password1;
  final TextEditingController password2;
  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> obscurePassword1;
  final ValueNotifier<bool> obscurePassword2;
  final ValueNotifier<bool> acceptTerms;
  final ValueNotifier<bool> acceptTermsHasError;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 72.h),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: AppColor.colorFFFFFF,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: AppColor.shadow,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.verticalSpace,
              CustomImage(Assets.images.authImage.path, width: 122.w),
              20.verticalSpace,
              AppText.sp24("Create Account").w700.black,
              20.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.sp14(
                    "Email address",
                  ).w400.setColor(AppColor.color333333),
                  6.verticalSpace,
                  BorderTextField(
                    controller: email,
                    keyboardType: TextInputType.text,
                    hint: "Enter your email address",
                    validator: (v) => AppValidators.email(v?.trim()),
                  ),
                ],
              ),
              22.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.sp14(
                    "New password",
                  ).w400.setColor(AppColor.color333333),
                  6.verticalSpace,
                  ValueListenableBuilder(
                    valueListenable: obscurePassword1,
                    builder: (context, value, child) {
                      return BorderTextField(
                        controller: password1,
                        hint: "Must be 8 characters",
                        keyboardType: TextInputType.text,
                        suffixIcon: svgPicture(value),
                        obscureText: value,
                        clickSuffix: () {
                          obscurePassword1.value = !obscurePassword1.value;
                        },
                        validator: AppValidators.passwordStrong,
                      );
                    },
                  ),
                ],
              ),
              22.verticalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.sp14(
                    "Confirm new password",
                  ).w400.setColor(AppColor.color333333),
                  6.verticalSpace,
                  ValueListenableBuilder(
                    valueListenable: obscurePassword2,
                    builder: (context, value, child) {
                      return BorderTextField(
                        controller: password2,
                        hint: "Must be 8 characters",
                        keyboardType: TextInputType.text,
                        suffixIcon: svgPicture(value),
                        obscureText: value,
                        clickSuffix: () {
                          obscurePassword2.value = !obscurePassword2.value;
                        },
                        validator: (v) {
                          if (password1.text != v) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      );
                    },
                  ),
                ],
              ),
              22.verticalSpace,
              MultiValueListenableBuilder(
                valueListenables: [acceptTerms, acceptTermsHasError],
                builder: (context, value, child) {
                  return PrivacyPolicyWidget(
                    value: acceptTerms.value,
                    hasError: acceptTermsHasError.value,
                    onChanged: (v) {
                      acceptTerms.value = v;
                      if (v) acceptTermsHasError.value = false;
                    },
                    clickPolicy: _openPrivacyPolicy,
                  );
                },
              ),
              22.verticalSpace,
              AppGradientButton(text: "Next", onTap: () => _next(context)),
              40.verticalSpace,
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  children: [
                    TextSpan(
                      text: " Log in",
                      style: TextStyle(
                        color: AppColor.color0B8AE1,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                      ),
                      recognizer:
                          TapGestureRecognizer()..onTap = () => _login(context),
                    ),
                  ],
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.color333333,
                    fontFamily: AppText.fontFamily,
                    height: 1.25,
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

  Widget svgPicture(bool visible) => SvgPicture.asset(
    visible ? Assets.svg.visible : Assets.svg.nonVisible,
    width: 17.w,
    colorFilter: const ColorFilter.mode(AppColor.color6D6D6D, BlendMode.srcIn),
  );

  void _next(BuildContext context) {
    // if (validate()) {
    controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    // }
  }

  bool buttonEnabled() {
    return email.text.isNotEmpty &&
        password1.text.isNotEmpty &&
        password2.text.isNotEmpty &&
        acceptTerms.value;
  }

  void _openPrivacyPolicy() {}

  bool validate() {
    bool hasError = formKey.currentState?.validate() ?? false;
    if (!acceptTerms.value) {
      acceptTermsHasError.value = true;
      hasError = false;
    }
    return hasError;
  }

  void _login(BuildContext context) {
    context.pushNamedAndRemoveUntil(AppRoutes.login, (_) => false);
  }
}
