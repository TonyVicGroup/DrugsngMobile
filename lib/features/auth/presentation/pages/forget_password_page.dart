import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/enum/otp_type_enum.dart';
import 'package:drugs_ng/core/widgets/buttons/app_back_button.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_validators.dart';
import 'package:drugs_ng/core/widgets/textfield/border_text_field.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/forget_password_cubit.dart';
import 'package:drugs_ng/features/auth/presentation/pages/email_otp_page.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();

  static Route<dynamic> route(RouteSettings settings) => MaterialPageRoute(
    builder: (_) => const ForgetPasswordPage(),
    settings: settings,
  );
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final emailCntrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state.sendResetStatus.isSuccess) {
            _verifySuccess();
          } else if (state.sendResetStatus.isFailed) {
            AppToast.warn(context, state.error?.message ?? 'An error occurred');
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.verticalSpace,
                    AppBackButton.light(_back),
                    20.verticalSpace,
                    Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: AppColor.colorFFFFFF,
                        borderRadius: BorderRadius.circular(30.r),
                        boxShadow: AppColor.shadow,
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            10.verticalSpace,
                            CustomImage(
                              Assets.images.authImage.path,
                              width: 122.w,
                            ),
                            12.verticalSpace,
                            AppText.sp30(
                              "Forgot password?",
                            ).w500.setColor(AppColor.color333333),
                            13.verticalSpace,
                            AppText.sp16(
                              "Don't worry! It happens. Please enter the email associated with your account.",
                            ).w400.setColor(AppColor.color6D6D6D).centerText,
                            30.verticalSpace,
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText.sp14(
                                  "Email address",
                                ).w400.setColor(AppColor.color333333),
                                6.verticalSpace,
                                BorderTextField(
                                  controller: emailCntrl,
                                  keyboardType: TextInputType.text,
                                  hint: "your@email.com",
                                  validator: AppValidators.email,
                                ),
                              ],
                            ),
                            40.verticalSpace,
                            AppGradientButton(
                              text: "Send code",
                              onTap: () => _sendCode(context),
                              status:
                                  state.sendResetStatus.isLoading
                                      ? ButtonStatus.loading
                                      : ButtonStatus.active,
                            ),
                            24.verticalSpace,
                            RichText(
                              text: TextSpan(
                                text: "Remember password? ",
                                children: [
                                  TextSpan(
                                    text: " Log in",
                                    style: TextStyle(
                                      color: AppColor.color0B8AE1,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()..onTap = _login,
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
                            14.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _back() {
    Navigator.of(context).pop();
  }

  void _sendCode(BuildContext context) {
    // if (formKey.currentState?.validate() ?? false) {
    //   context.read<ForgetPasswordCubit>().sendPasswordReset(emailCntrl.text);
    // }
    _verifySuccess();
  }

  void _login() {
    Navigator.of(context).pop();
  }

  _verifySuccess() {
    EmailOtpPage.verifyOtp(
      context: context,
      email: emailCntrl.text,
      otpType: OtpTypeEnum.passwordReset,
    );
  }
}
