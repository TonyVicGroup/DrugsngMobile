import 'package:drugs_ng/src/core/enum/button_status.dart';
import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/ui/app_text_field.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/core/utils/app_validators.dart';
import 'package:drugs_ng/src/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:drugs_ng/src/features/auth/presentation/cubit/signup_cubit.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/login_page.dart';
import 'package:drugs_ng/src/features/auth/presentation/widgets/privacy_policy_widget.dart';
import 'package:drugs_ng/src/features/auth/presentation/widgets/weekly_update_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final emailCntrl = TextEditingController();
  final password1Cntrl = TextEditingController();
  final password2Cntrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool obscurePassword1 = true;
  bool obscurePassword2 = true;
  bool acceptTerms = false;
  bool getWeeklyUpdate = false;
  bool acceptTermsHasError = false;

  @override
  void dispose() {
    emailCntrl.dispose();
    password1Cntrl.dispose();
    password2Cntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(context.read<AuthRepository>()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                148.verticalSpace,
                AppText.sp30("Create account").w800.black,
                30.verticalSpace,
                AppText.sp14("Email address").w400.black,
                6.verticalSpace,
                AppTextField.text(
                  controller: emailCntrl,
                  keyboardType: TextInputType.text,
                  hint: "Enter your email address",
                  validator: AppValidators.email,
                ),
                22.verticalSpace,
                AppText.sp14("New password").w400.black,
                6.verticalSpace,
                AppTextField.text(
                  controller: password1Cntrl,
                  hint: "Must be 8 characters",
                  keyboardType: TextInputType.text,
                  suffixIcon: svgPicture(obscurePassword1),
                  obscureText: obscurePassword1,
                  clickSuffix: _toggleVisibility1,
                  validator: AppValidators.password,
                ),
                22.verticalSpace,
                AppText.sp14("Confirm new password").w400.black,
                6.verticalSpace,
                AppTextField.text(
                  controller: password2Cntrl,
                  hint: "Must be 8 characters",
                  keyboardType: TextInputType.text,
                  suffixIcon: svgPicture(obscurePassword2),
                  obscureText: obscurePassword2,
                  clickSuffix: _toggleVisibility2,
                  validator: (v) {
                    if (password1Cntrl.text != v) {
                      return "Password must be same";
                    }
                    return null;
                  },
                ),
                22.verticalSpace,
                PrivacyPolicyWidget(
                  value: acceptTerms,
                  hasError: acceptTermsHasError,
                  onChanged: (v) {
                    setState(() {
                      acceptTerms = v;
                      if (v) {
                        acceptTermsHasError = false;
                      }
                    });
                  },
                  clickPolicy: _openPrivacyPolicy,
                ),
                22.verticalSpace,
                WeeklyUpdateWidget(
                  value: getWeeklyUpdate,
                  onChanged: (v) => setState(() => getWeeklyUpdate = v),
                ),
                const Spacer(),
                BlocBuilder<SignupCubit, SignupState>(
                  builder: (context, state) {
                    return AppButton.primary(
                      text: "Next",
                      onTap: () => _next(context),
                      status: state == SignupState.loading
                          ? ButtonStatus.loading
                          : ButtonStatus.active,
                    );
                  },
                ),
                40.verticalSpace,
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
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
      ),
    );
  }

  Widget svgPicture(bool visible) => SvgPicture.asset(
        visible ? AppSvg.visible : AppSvg.notVisible,
        width: 17.w,
        colorFilter: const ColorFilter.mode(
          AppColor.darkGrey,
          BlendMode.srcIn,
        ),
      );

  void _toggleVisibility1() {
    setState(() => obscurePassword1 = !obscurePassword1);
  }

  void _openPrivacyPolicy() {}

  void _toggleVisibility2() {
    setState(() => obscurePassword2 = !obscurePassword2);
  }

  bool validate() {
    bool hasError = formKey.currentState?.validate() ?? false;
    if (!acceptTerms) {
      setState(() {
        acceptTermsHasError = true;
        hasError = false;
      });
    }
    return hasError;
  }

  void _next(BuildContext context) {
    if (validate()) {
      context.read<SignupCubit>().createAccount(SignupData(
            email: emailCntrl.text,
            password: password1Cntrl.text,
            getWeeklyUpdates: getWeeklyUpdate,
          ));
    }
  }

  void _login() {
    Navigator.of(context).pushAndRemoveUntil(
      PageTransition(
        type: PageTransitionType.fade,
        child: const LoginPage(),
        duration: AppUtils.kPageTransitionDuration,
      ),
      (route) => route.isFirst,
    );
  }
}
