import 'package:drugs_ng/src/core/enum/button_status.dart';
import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/ui/app_text_field.dart';
import 'package:drugs_ng/src/core/ui/app_toast.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/core/utils/app_validators.dart';
import 'package:drugs_ng/src/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:drugs_ng/src/features/auth/presentation/cubit/signup_cubit.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/login_page.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/setup_profile_page.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/email_otp_page.dart';
import 'package:drugs_ng/src/features/auth/presentation/widgets/privacy_policy_widget.dart';
import 'package:drugs_ng/src/features/auth/presentation/widgets/weekly_update_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  bool obscurePassword = true;
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
                  suffixIcon: svgPicture(obscurePassword),
                  obscureText: obscurePassword,
                  clickSuffix: _toggleVisibility,
                  validator: AppValidators.password,
                ),
                22.verticalSpace,
                AppText.sp14("Confirm new password").w400.black,
                6.verticalSpace,
                AppTextField.text(
                  controller: password2Cntrl,
                  hint: "Must be 8 characters",
                  keyboardType: TextInputType.text,
                  suffixIcon: svgPicture(obscurePassword),
                  obscureText: obscurePassword,
                  clickSuffix: _toggleVisibility,
                  validator: (v) {
                    if (password1Cntrl.text != v) {
                      return "Passwords do not match";
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
                      if (v) acceptTermsHasError = false;
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
                BlocConsumer<SignupCubit, SignupState>(
                  listener: (context, state) {
                    if (state is SignupStateSuccess) {
                      Navigator.push(
                        context,
                        AppUtils.transition(EmailOtpPage(
                          email: emailCntrl.text,
                          handler: EmailOtpHandler(
                            onSuccess: (otp) {
                              Navigator.push(
                                context,
                                AppUtils.transition(
                                  SetupProfilePage(user: state.userData),
                                ),
                              );
                            },
                            onVerifyOtp: (otp, bloc) {
                              bloc.verifyAccountConfirmOTP(otp);
                            },
                            onResendOtp: (bloc) {
                              bloc.resendAccountConfirmOtp(emailCntrl.text);
                            },
                          ),
                        )),
                      );
                    } else if (state is SignupStateError) {
                      AppToast.warning(context, state.error.message);
                    }
                  },
                  builder: (context, state) {
                    return AppButton.primary(
                      text: "Next",
                      onTap: () => _next(context),
                      status: state is SignupStateLoading
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

  void _toggleVisibility() {
    setState(() => obscurePassword = !obscurePassword);
  }

  void _openPrivacyPolicy() {}

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
      AppUtils.transition(const LoginPage()),
      (route) => route.isFirst,
    );
  }
}
