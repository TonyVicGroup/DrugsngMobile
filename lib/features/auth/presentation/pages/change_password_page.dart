import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/navigation/app_route.dart';
import 'package:drugs_ng/core/widgets/buttons/app_back_button.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_validators.dart';
import 'package:drugs_ng/core/widgets/textfield/border_text_field.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/forget_password_cubit.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();

  static Route<dynamic> route(RouteSettings settings) => MaterialPageRoute(
    builder: (_) => const ChangePasswordPage(),
    settings: settings,
  );
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final password1 = TextEditingController();
  final password2 = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final obscurePassword1 = ValueNotifier<bool>(true);
  final obscurePassword2 = ValueNotifier<bool>(true);

  @override
  void dispose() {
    password1.dispose();
    password2.dispose();
    obscurePassword1.dispose();
    obscurePassword2.dispose();
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
                              Assets.images.verifyImage.path,
                              width: 122.w,
                            ),
                            12.verticalSpace,
                            AppText.sp30(
                              "Change Password",
                            ).w500.setColor(AppColor.color333333),
                            13.verticalSpace,
                            AppText.sp16(
                              "Do well to type what you'll remember",
                            ).w400.setColor(AppColor.color6D6D6D).centerText,
                            30.verticalSpace,
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
                                        obscurePassword1.value =
                                            !obscurePassword1.value;
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
                                        obscurePassword2.value =
                                            !obscurePassword2.value;
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
                            40.verticalSpace,
                            AppGradientButton(
                              text: "Save New Password",
                              onTap: () => _saveNewPassword(context),
                              status:
                                  state.sendResetStatus.isLoading
                                      ? ButtonStatus.loading
                                      : ButtonStatus.active,
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

  void _saveNewPassword(BuildContext context) {
    // if (formKey.currentState?.validate() ?? false) {
    //   context.read<ForgetPasswordCubit>().sendPasswordReset(emailCntrl.text);
    // }
    context.pushNamed(AppRoutes.changePasswordSucces);
  }

  _verifySuccess() {
    // EmailOtpPage.verifyOtp(
    //   context: context,
    //   email: emailCntrl.text,
    //   otpType: OtpTypeEnum.passwordReset,
    // );
  }

  Widget svgPicture(bool visible) => SvgPicture.asset(
    visible ? Assets.svg.visible : Assets.svg.nonVisible,
    width: 17.w,
    colorFilter: const ColorFilter.mode(AppColor.color6D6D6D, BlendMode.srcIn),
  );
}
