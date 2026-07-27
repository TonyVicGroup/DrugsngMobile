import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/extensions/string_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/verification/presentation/cubit/phone_otp_verification_cubit.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationModal extends StatefulWidget {
  const OtpVerificationModal({super.key});

  static Future<void> show(BuildContext context) async {
    context.showBottomModal(
      child: BlocProvider(
        create: (context) => PhoneOtpVerificationCubit(),
        child: OtpVerificationModal(),
      ),
    );
  }

  @override
  State<OtpVerificationModal> createState() => _OtpVerificationModalState();
}

class _OtpVerificationModalState extends State<OtpVerificationModal> {
  late final TextEditingController otpCntrl;

  @override
  void initState() {
    super.initState();
    otpCntrl = TextEditingController();
  }

  @override
  void dispose() {
    // otpCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneOtpVerificationCubit, PhoneOtpVerificationState>(
      builder: (context, state) {
        return Material(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
          color: AppColor.colorFFFFFF,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                12.verticalSpace,
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColor.colorE0E0E0,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                20.verticalSpace,
                Container(
                  width: 72.r,
                  height: 72.r,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.color0B8AE1.withAlpha(25),
                  ),
                  child: CustomImage(
                    Assets.svg.phone,
                    height: 30.r,

                    color: AppColor.color0B8AE1,
                  ),
                ),
                10.verticalSpace,
                AppText.sp20(
                  'OTP Verification',
                ).w700.setColor(AppColor.color111827),
                10.verticalSpace,
                SizedBox(
                  width: 311.w,
                  child:
                      AppText.sp14(
                        'An OTP has been sent to the phone number tied to your Identity.',
                      ).w400.setColor(AppColor.color6B7280).centerText,
                ),
                5.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.colorF9FAFB,
                    borderRadius: BorderRadius.circular(2.r),
                    border: Border.all(color: AppColor.colorE5E7EB),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomImage(
                        Assets.svg.halfShield,
                        height: 16.r,
                        width: 16.r,
                        color: AppColor.color0B8AE1,
                      ),
                      5.horizontalSpace,
                      AppText.sp13(
                        "09020932303".hideNumber,
                      ).w600.setColor(AppColor.color111827),
                    ],
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: PinCodeTextField(
                    controller: otpCntrl,
                    keyboardType: TextInputType.number,
                    appContext: context,
                    autoFocus: true,
                    length: 6,
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
                      fieldWidth: 48.w,
                      activeColor: AppColor.colorBDC4CD,
                      inactiveFillColor: AppColor.colorBDC4CD,
                      activeFillColor: AppColor.colorBDC4CD,
                      inactiveColor: AppColor.colorBDC4CD,
                    ),
                  ),
                ),
                10.verticalSpace,
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
                              state.resendStatus.isLoading ? null : resendCode,
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
                30.verticalSpace,
                ValueListenableBuilder(
                  valueListenable: otpCntrl,
                  builder: (context, value, child) {
                    return AppGradientButton(
                      text: "Verify",
                      onTap: _verifyOtp,
                      // status:
                      //     state.status.isLoading
                      //         ? ButtonStatus.loading
                      //         : ButtonStatus.active,
                    );
                  },
                ),
                30.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _verifyOtp() async {
    context.pop();
  }

  Future<void> resendCode() async {}

  String _countdownText(int countdown) {
    int seconds = countdown % 60;
    int minute = (countdown / 60).floor();
    String sec = "$seconds".padLeft(2, '0');
    String min = "$minute".padLeft(2, '0');
    return "$min:$sec";
  }
}
