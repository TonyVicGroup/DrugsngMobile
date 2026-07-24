import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/enum/gender_enum.dart';
import 'package:drugs_ng/core/enum/otp_type_enum.dart';
import 'package:drugs_ng/core/utils/app_validators.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_back_button.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/widgets/textfield/border_text_field.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/signup_cubit.dart';
import 'package:drugs_ng/features/auth/presentation/pages/email_otp_page.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetupProfileTab extends StatelessWidget {
  const SetupProfileTab({
    super.key,
    required this.controller,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthDay,
    required this.gender,
  });
  final PageController controller;
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController email;
  final ValueNotifier<DateTime> birthDay;
  final ValueNotifier<GenderEnum> gender;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBackButton.light(_goBack),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 72.h),
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: AppColor.colorFFFFFF,
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: AppColor.shadow,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                10.verticalSpace,
                CustomImage(Assets.images.authImage.path, width: 122.w),
                20.verticalSpace,
                AppText.sp24("Set up profile").w700.black,
                20.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.sp14(
                      "First name",
                    ).w400.setColor(AppColor.color333333),
                    6.verticalSpace,
                    BorderTextField(
                      controller: firstName,
                      keyboardType: TextInputType.text,
                      hint: "Your name",
                      validator: AppValidators.name,
                    ),
                  ],
                ),
                22.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.sp14(
                      "Last name",
                    ).w400.setColor(AppColor.color333333),
                    6.verticalSpace,
                    BorderTextField(
                      controller: lastName,
                      hint: "Your surname",
                      keyboardType: TextInputType.text,
                      validator: AppValidators.name,
                    ),
                  ],
                ),
                22.verticalSpace,
                BlocConsumer<SignupCubit, SignupState>(
                  listener: (context, state) {
                    if (state.status.isSuccess) {
                      _signupSuccess(context);
                    } else if (state.status.isFailed) {
                      _signupFailed(context, state.error?.message);
                    }
                  },
                  builder: (context, state) {
                    return AppGradientButton(
                      text: "Done",
                      onTap: () => _next(context),
                      status:
                          state.status.isLoading
                              ? ButtonStatus.loading
                              : (buttonEnabled()
                                  ? ButtonStatus.active
                                  : ButtonStatus.disabled),
                    );
                  },
                ),
                54.verticalSpace,
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _next(BuildContext context) {
    if (!buttonEnabled()) {
      return;
    }
    final signupState = context.read<SignupCubit>().state;
    if (!signupState.status.isLoading) {
      // context.read<SignupCubit>().signup();
    }
  }

  bool buttonEnabled() {
    return firstName.text.trim().isNotEmpty && lastName.text.trim().isNotEmpty;
  }

  Future<void> _signupSuccess(BuildContext context) async {
    EmailOtpPage.verifyOtp(
      context: context,
      email: email.text,
      otpType: OtpTypeEnum.emailConfirmation,
    );
  }

  Future<void> _signupFailed(BuildContext context, String? message) async {
    AppToast.warn(context, message ?? 'An Error occured');
  }

  void _goBack() {
    controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}
