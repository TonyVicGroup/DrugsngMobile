import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/navigation/app_route.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/widget_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/utils/app_validators.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/textfield/border_text_field.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/login_cubit.dart';
import 'package:drugs_ng/features/auth/presentation/widgets/biometric_modal.dart';
import 'package:drugs_ng/features/auth/presentation/widgets/or_text_divider.dart';
import 'package:drugs_ng/features/navigation/presentation/pages/tab_overlay.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

  static Route<dynamic> route(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => const LoginPage());
  }
}

class _LoginPageState extends State<LoginPage> {
  final emailCntrl = TextEditingController();
  final passwordCntrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    context.read<LoginCubit>().reset();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<AuthCubit>().state.isLoggedIn) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const TabOverlay()),
          (route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    emailCntrl.dispose();
    passwordCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) => context.isOnScreen,
      listener: (context, state) {
        if (state.isLoggedIn) {
          // Navigate to the home page or any other page after successful login
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const TabOverlay()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 72.h),
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: AppColor.colorFFFFFF,
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: AppColor.shadow,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                24.verticalSpace,
                CustomImage(Assets.images.authImage.path, height: 87.h),
                12.verticalSpace,
                AppText.sp30("Log in").w500.black,
                5.verticalSpace,
                AppText.sp18(
                  "Welcome back!",
                ).w400.setColor(AppColor.color6D6D6D),
                12.verticalSpace,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.sp14("Email").w400.setColor(AppColor.color333333),
                    6.verticalSpace,
                    BorderTextField(
                      hint: "Your email",
                      controller: emailCntrl,
                      keyboardType: TextInputType.text,
                      clickSuffix: _toggleVisibility,
                      validator: AppValidators.email,
                    ),
                  ],
                ),
                12.verticalSpace,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.sp14("Password").w400
                      ..setColor(AppColor.color333333),
                    6.verticalSpace,
                    BorderTextField(
                      hint: "Password",
                      controller: passwordCntrl,
                      keyboardType: TextInputType.text,
                      suffixIcon: svgPicture(),
                      obscureText: obscurePassword,
                      clickSuffix: _toggleVisibility,
                      validator: AppValidators.password,
                    ),
                  ],
                ),
                16.verticalSpace,
                Align(
                  alignment: Alignment.centerRight,
                  child: AppText.sp14("Forgot password?")
                      .setColor(AppColor.color0B8AE1)
                      .w400
                      .clickable(_forgetPassword),
                ),
                16.verticalSpace,
                BlocConsumer<LoginCubit, LoginState>(
                  listenWhen: (previous, current) => context.isOnScreen,
                  listener: (BuildContext context, LoginState state) {
                    // if (state.isLoggedIn) {
                    //   if (state.error != null) {
                    //     AppToast.warn(context, state.error!);
                    //     // handle confirmation of email if needed
                    //     if (state.error!.toLowerCase().contains(
                    //       "confirm your email",
                    //     )) {
                    //       EmailOtpPage.verifyOtp(
                    //         context: context,
                    //         email: emailCntrl.text,
                    //         otpType: OtpTypeEnum.emailConfirmation,
                    //       );
                    //     }
                    //   }
                    // }
                  },
                  builder: (context, state) {
                    return AppGradientButton(
                      text: "Login",
                      onTap: () => _login(context),
                    );
                  },
                ),
                16.verticalSpace,
                OrTextDivider(),
                16.verticalSpace,
                AppButtonAnimator(
                  onTap: _useBiometric,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 69.r,
                        height: 69.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.colorFFFFFF,
                          boxShadow: AppColor.shadow,
                          shape: BoxShape.circle,
                        ),
                        child: CustomImage(
                          Assets.svg.biometric,
                          width: 33.r,
                          height: 33.r,
                        ),
                      ),
                      6.verticalSpace,
                      AppText.sp14(
                        "Use Biometric Login",
                      ).w500.setColor(AppColor.color333333),
                      AppText.sp14(
                        "Face ID / Touch ID",
                      ).w400.setColor(AppColor.color333333),
                    ],
                  ),
                ),
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
                            color: AppColor.color0B8AE1,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = _signup,
                        ),
                      ],
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.color333333,
                        fontFamily: AppText.fontFamily,
                        height: 1.25,
                      ),
                    ),
                  ),
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget svgPicture() => SvgPicture.asset(
    obscurePassword ? Assets.svg.visible : Assets.svg.nonVisible,
    width: 17.w,
    colorFilter: const ColorFilter.mode(AppColor.darkGrey, BlendMode.srcIn),
  );

  void _toggleVisibility() {
    setState(() => obscurePassword = !obscurePassword);
  }

  void _forgetPassword() {
    context.pushNamed(AppRoutes.forgetPassword);
  }

  void _useBiometric() {
    if (context.read<LoginCubit>().state.isBiometricEnabled) {
      context.read<LoginCubit>().biometricLogin();
    } else {
      BiometricModal.show(context);
    }
  }

  void _login(BuildContext context) {
    // if (formKey.currentState?.validate() ?? false) {
    //   context.read<LoginCubit>().login(emailCntrl.text, passwordCntrl.text);
    // }
    _onSuccess();
  }

  void _signup() {
    context.pushNamed(AppRoutes.signup);
  }

  void _onSuccess() {
    context.pushNamed(AppRoutes.selectAccountType);
  }
}
