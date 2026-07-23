import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/otp_type_enum.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/app_text_field.dart';
import 'package:drugs_ng/core/widgets/app_toast.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/core/utils/app_validators.dart';
import 'package:drugs_ng/features/auth/domain/models/auth_models.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/signup_cubit.dart';
import 'package:drugs_ng/features/auth/presentation/pages/login_page.dart';
import 'package:drugs_ng/features/auth/presentation/pages/email_otp_page.dart';
import 'package:drugs_ng/features/auth/presentation/widgets/privacy_policy_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();

  static Route<dynamic> route(RouteSettings route) {
    return MaterialPageRoute(builder: (_) => const CreateAccountPage());
  }
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final emailCntrl = TextEditingController();
  final firstNameCntrl = TextEditingController();
  final lastNameCntrl = TextEditingController();
  final password1Cntrl = TextEditingController();
  final password2Cntrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ValueNotifier<bool> obscurePassword1 = ValueNotifier<bool>(true);
  ValueNotifier<bool> obscurePassword2 = ValueNotifier<bool>(true);
  ValueNotifier<bool> acceptTerms = ValueNotifier<bool>(false);
  // bool getWeeklyUpdate = false;
  ValueNotifier<bool> acceptTermsHasError = ValueNotifier<bool>(false);

  @override
  void dispose() {
    firstNameCntrl.dispose();
    lastNameCntrl.dispose();
    emailCntrl.dispose();
    password1Cntrl.dispose();
    password2Cntrl.dispose();
    // dispose value notifiers
    obscurePassword1.dispose();
    obscurePassword2.dispose();
    acceptTerms.dispose();
    acceptTermsHasError.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  120.verticalSpace,
                  AppText.sp30("Create account").w800.black,
                  30.verticalSpace,
                  AppText.sp14("First name").w400.black,
                  6.verticalSpace,
                  AppTextField.text(
                    controller: firstNameCntrl,
                    keyboardType: TextInputType.text,
                    hint: "Your name",
                    validator: AppValidators.name,
                  ),
                  22.verticalSpace,
                  AppText.sp14("Last name").w400.black,
                  6.verticalSpace,
                  AppTextField.text(
                    controller: lastNameCntrl,
                    hint: "Your surname",
                    keyboardType: TextInputType.text,
                    validator: AppValidators.name,
                  ),
                  22.verticalSpace,
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
                  ValueListenableBuilder(
                    valueListenable: obscurePassword1,
                    builder: (context, value, child) {
                      return AppTextField.text(
                        controller: password1Cntrl,
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
                  22.verticalSpace,
                  AppText.sp14("Confirm new password").w400.black,
                  6.verticalSpace,
                  ValueListenableBuilder(
                    valueListenable: obscurePassword2,
                    builder: (context, value, child) {
                      return AppTextField.text(
                        controller: password2Cntrl,
                        hint: "Must be 8 characters",
                        keyboardType: TextInputType.text,
                        suffixIcon: svgPicture(value),
                        obscureText: value,
                        clickSuffix: () {
                          obscurePassword2.value = !obscurePassword2.value;
                        },
                        validator: (v) {
                          if (password1Cntrl.text != v) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      );
                    },
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
                  BlocConsumer<SignupCubit, SignupState>(
                    listener: (context, state) {
                      if (state is SignupStateSuccess) {
                        EmailOtpPage.verifyOtp(
                          context: context,
                          email: emailCntrl.text,
                          otpType: OtpTypeEnum.emailConfirmation,
                        );
                      } else if (state is SignupStateError) {
                        AppToast.warning(context, state.error.message);
                      }
                    },
                    builder: (context, state) {
                      return MultiValueListenableBuilder(
                        valueListenables: [
                          firstNameCntrl,
                          lastNameCntrl,
                          emailCntrl,
                          password1Cntrl,
                          password2Cntrl,
                          acceptTerms,
                        ],
                        builder: (context, value, child) {
                          return AppButton.primary(
                            text: "Next",
                            onTap: () => _next(context),
                            status:
                                state is SignupStateLoading
                                    ? ButtonStatus.loading
                                    : (buttonEnabled()
                                        ? ButtonStatus.active
                                        : ButtonStatus.disabled),
                          );
                        },
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
      ),
    );
  }

  bool buttonEnabled() {
    return firstNameCntrl.text.isNotEmpty &&
        lastNameCntrl.text.isNotEmpty &&
        emailCntrl.text.isNotEmpty &&
        password1Cntrl.text.isNotEmpty &&
        password2Cntrl.text.isNotEmpty &&
        acceptTerms.value;
  }

  Widget svgPicture(bool visible) => SvgPicture.asset(
    visible ? AppSvg.visible : AppSvg.notVisible,
    width: 17.w,
    colorFilter: const ColorFilter.mode(AppColor.darkGrey, BlendMode.srcIn),
  );

  void _openPrivacyPolicy() {}

  bool validate() {
    bool hasError = formKey.currentState?.validate() ?? false;
    if (!acceptTerms.value) {
      acceptTermsHasError.value = true;
      hasError = false;
    }
    return hasError;
  }

  void _next(BuildContext context) {
    if (validate()) {
      context.read<SignupCubit>().createAccount(
        SignupData(
          email: emailCntrl.text,
          firstName: firstNameCntrl.text,
          lastName: lastNameCntrl.text,
          password: password1Cntrl.text,
          getWeeklyUpdates: false,
        ),
      );
    }
  }

  void _login() {
    Navigator.of(context).pushAndRemoveUntil(
      AppUtils.transition(const LoginPage()),
      (route) => route.isFirst,
    );
  }
}
