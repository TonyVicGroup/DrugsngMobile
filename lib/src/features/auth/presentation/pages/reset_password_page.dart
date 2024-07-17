import 'package:drugs_ng/src/core/enum/button_status.dart';
import 'package:drugs_ng/src/core/ui/app_toast.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/ui/app_text_field.dart';
import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:drugs_ng/src/features/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/confirmation_page.dart';
import 'package:drugs_ng/src/core/utils/app_validators.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, required this.otp});
  final String otp;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final password1Cntrl = TextEditingController();
  final password2Cntrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  @override
  void dispose() {
    password1Cntrl.dispose();
    password2Cntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(context.read<AuthRepository>()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                64.verticalSpace,
                AppButton.roundedBack(_back),
                45.verticalSpace,
                AppText.sp30("Reset password").w800.black,
                13.verticalSpace,
                AppText.sp16("Do well to type what you'll remember")
                    .w400
                    .darkGrey,
                40.verticalSpace,
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
                40.verticalSpace,
                const Spacer(),
                BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                  listener: (context, state) {
                    if (state is ResetPasswordSuccess) {
                      Navigator.push(
                        context,
                        AppUtils.transition(ConfirmationPage(
                          title: "Password changed",
                          subtitle:
                              "Great! Your password has been changed successfully.",
                          btnText: "Back to login",
                          onTap: _backToLogin,
                        )),
                      );
                    }
                    if (state is ResetPasswordError) {
                      AppToast.warning(context, state.error.message);
                    }
                  },
                  builder: (context, state) {
                    return AppButton.primary(
                        text: "Reset password",
                        onTap: () => _resetPassword(context),
                        status: state is ResetPasswordLoading
                            ? ButtonStatus.loading
                            : ButtonStatus.active);
                  },
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
        colorFilter: const ColorFilter.mode(AppColor.darkGrey, BlendMode.srcIn),
      );

  void _toggleVisibility() {
    setState(() => obscurePassword = !obscurePassword);
  }

  void _back() => Navigator.of(context).pop();

  void _resetPassword(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.read<ResetPasswordCubit>().resetPassword(
            password1Cntrl.text,
            widget.otp,
          );
    }
  }

  void _backToLogin() {
    Navigator.of(context).pushAndRemoveUntil(
      AppUtils.transition(const LoginPage()),
      (route) => route.isFirst,
    );
  }
}
