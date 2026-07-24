import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/enum/otp_type_enum.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/navigation/app_route.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/verify_email_otp_cubit.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/auth/presentation/pages/login_page.dart';
import 'package:drugs_ng/features/auth/presentation/pages/reset_password_page.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailOtpPage extends StatefulWidget {
  final int inputLength;
  final String email;
  final OtpTypeEnum otpType;

  const EmailOtpPage._({
    required this.email,
    this.inputLength = 6,
    required this.otpType,
  });

  @override
  State<EmailOtpPage> createState() => _EmailOtpPageState();

  static void verifyOtp({
    required BuildContext context,
    required String email,
    required OtpTypeEnum otpType,
    int inputLength = 6,
  }) {
    context.pushNamed(
      AppRoutes.emailOtp,
      arguments: {
        'email': email,
        'otpType': otpType,
        'inputLength': inputLength,
      },
    );
  }

  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;
    final email = args?['email'] as String?;
    final otpType = args?['otpType'] as OtpTypeEnum?;
    final inputLength = args?['inputLength'] as int?;

    return MaterialPageRoute(
      builder:
          (_) => BlocProvider(
            create: (context) => EmailOtpCubit(otpType: otpType, email: email),
            child: EmailOtpPage._(
              email: email!,
              otpType: otpType!,
              inputLength: inputLength!,
            ),
          ),
      settings: settings,
    );
  }
}

class _EmailOtpPageState extends State<EmailOtpPage> {
  final TextEditingController otpCntrl = TextEditingController();

  // CountdownTimerController? timerController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // otpCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resendCodeTextStyle = TextStyle(
      fontSize: 16.sp,
      height: 1.25,
      fontWeight: FontWeight.w600,
      fontFamily: AppText.fontFamily,
    );
    return BlocConsumer<EmailOtpCubit, EmailOtpState>(
      listenWhen:
          (prev, current) =>
              context.isOnScreen &&
              (prev.status != current.status ||
                  prev.resendStatus != current.resendStatus),
      listener: (context, state) {
        if (state.status.isSuccess) {
          if (widget.otpType.isEmailConfirmation) {
            Navigator.pushAndRemoveUntil(
              context,
              AppUtils.transition(const LoginPage()),
              (_) => false,
            );
            AppToast.success(
              context,
              'Your account has been created.\nYou can now login.',
            );
          } else {
            AppToast.success(
              context,
              'Invalid Type Please go back and try again.',
            );
          }
        } else if (state.status.isFailed || state.resendStatus.isFailed) {
          AppToast.warn(context, state.error!.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 72.h),
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppColor.colorFFFFFF,
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: AppColor.shadow,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    30.verticalSpace,
                    CustomImage(Assets.images.authImage.path, width: 122.w),
                    30.verticalSpace,
                    AppText.sp24(
                      "Verify your email",
                    ).w500.setColor(AppColor.color333333),
                    13.verticalSpace,
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text:
                            "We've sent an mail with an OTP code to your email ",
                        children: [
                          TextSpan(
                            text: widget.email,
                            style: const TextStyle(color: AppColor.black),
                          ),
                        ],
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColor.darkGrey,
                        ),
                      ),
                    ),
                    30.verticalSpace,
                    PinCodeTextField(
                      controller: otpCntrl,
                      keyboardType: TextInputType.number,
                      appContext: context,
                      autoFocus: true,
                      length: widget.inputLength,
                      textStyle: TextStyle(
                        fontSize: 24.sp,
                        color: AppColor.color333333,
                        fontWeight: FontWeight.w400,
                      ),
                      pinTheme: PinTheme(
                        selectedColor: const Color.fromRGBO(189, 196, 205, 1),
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(15.r),
                        fieldHeight: 56.h,
                        fieldWidth: 56.w,
                        activeColor: AppColor.colorBDC4CD,
                        inactiveFillColor: AppColor.colorBDC4CD,
                        activeFillColor: AppColor.colorBDC4CD,
                        inactiveColor: AppColor.colorBDC4CD,
                      ),
                    ),
                    20.verticalSpace,
                    Align(
                      alignment: Alignment.center,
                      child: Builder(
                        builder: (context) {
                          if (state.countdown <= 0) {
                            return RichText(
                              text: TextSpan(
                                text: "I didn't receive a code",
                                children: [
                                  TextSpan(
                                    text: ' Resend Code',
                                    style: TextStyle(
                                      color: AppColor.color0B8AE1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ],
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  height: 1.25,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: AppText.fontFamily,
                                  color: AppColor.color6D6D6D,
                                ),
                              ),
                            );
                          } else if (state.resendStatus.isLoading) {
                            return GestureDetector(
                              onTap:
                                  state.resendStatus.isLoading
                                      ? null
                                      : resendCode,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppText.sp16(
                                    'Send code again',
                                  ).w400.setColor(AppColor.color6D6D6D),
                                  if (state.resendStatus.isLoading) ...[
                                    10.horizontalSpace,
                                    SizedBox(
                                      height: 16.h,
                                      width: 16.w,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 4.w,
                                        color: AppColor.color0B8AE1,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            );
                          }
                          return RichText(
                            text: TextSpan(
                              text: "Resend Code in",
                              children: [
                                TextSpan(
                                  text: '  ${_countdownText(state.countdown)}',
                                  style: TextStyle(
                                    color: AppColor.colorDC2626,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                              style: TextStyle(
                                fontSize: 16.sp,
                                height: 1.25,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppText.fontFamily,
                                color: AppColor.color6D6D6D,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    20.verticalSpace,
                    ValueListenableBuilder(
                      valueListenable: otpCntrl,
                      builder: (context, value, child) {
                        return AppGradientButton(
                          text: "Verify",
                          onTap: _sendCode,
                          status:
                              state.status.isLoading
                                  ? ButtonStatus.loading
                                  : ButtonStatus.active,
                        );
                      },
                    ),
                    18.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _countdownText(int countdown) {
    int seconds = countdown % 60;
    int minute = (countdown / 60).floor();
    String sec = "$seconds".padLeft(2, '0');
    String min = "$minute".padLeft(2, '0');
    return "$min:$sec";
  }

  void resendCode() {
    context.read<EmailOtpCubit>().resendOtp();
  }

  void _sendCode() {
    // if (widget.otpType.isPasswordReset) {
    //   AppUtils.pushWidget(
    //     BlocProvider.value(
    //       value: context.read<EmailOtpCubit>(),
    //       child: ResetPasswordPage(otp: otpCntrl.text, email: widget.email),
    //     ),
    //   );
    // } else {
    //   context.read<EmailOtpCubit>().confirmOtp(otp: otpCntrl.text);
    // }
    // context.read<EmailOtpCubit>().confirmOtp(otp: otpCntrl.text);
    context.pushNamed(AppRoutes.changePassword);
  }
}
