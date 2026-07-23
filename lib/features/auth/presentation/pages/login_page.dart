import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/core/enum/otp_type_enum.dart';
import 'package:drugs_ng/core/enum/request_status.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/widgets/app_toast.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/extensions/widget_extension.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/app_text_field.dart';
import 'package:drugs_ng/core/utils/app_validators.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/login_cubit.dart';
import 'package:drugs_ng/features/auth/presentation/pages/create_account_page.dart';
import 'package:drugs_ng/features/auth/presentation/pages/email_otp_page.dart';
import 'package:drugs_ng/features/auth/presentation/pages/forget_password_page.dart';
import 'package:drugs_ng/features/navigation/presentation/pages/tab_overlay.dart';
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
  final loginCntrl = TextEditingController();
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
    loginCntrl.dispose();
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
                  hint: "Password",
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
                  child: AppText.sp14(
                    "Forgot password?",
                  ).black.w400.clickable(_forgetPassword),
                ),
                40.verticalSpace,
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (BuildContext context, AuthState state) {
                    if (state.isLoggedIn) {
                      if (state.error != null) {
                        AppToast.warning(context, state.error!);
                        // handle confirmation of email if needed
                        if (state.error!.toLowerCase().contains(
                          "confirm your email",
                        )) {
                          EmailOtpPage.verifyOtp(
                            context: context,
                            email: loginCntrl.text,
                            otpType: OtpTypeEnum.emailConfirmation,
                          );
                        }
                      }
                    }
                  },
                  builder: (context, state) {
                    return AppButton.primary(
                      text: "Log in",
                      onTap: () => _login(context),
                      // status:
                      //     state is AuthLoadingState
                      //         ? ButtonStatus.loading
                      //         : ButtonStatus.active,
                    );
                  },
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
      ),
    );
  }

  Widget svgPicture() => SvgPicture.asset(
    obscurePassword ? AppSvg.visible : AppSvg.notVisible,
    width: 17.w,
    colorFilter: const ColorFilter.mode(AppColor.darkGrey, BlendMode.srcIn),
  );

  void _toggleVisibility() {
    setState(() => obscurePassword = !obscurePassword);
  }

  void _forgetPassword() {
    AppUtils.pushWidget(const ForgetPasswordPage());
  }

  void _login(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(loginCntrl.text, passwordCntrl.text);
    }
  }

  void _signup() {
    AppUtils.pushWidget(const CreateAccountPage());
  }
}
