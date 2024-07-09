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
import 'package:drugs_ng/src/features/auth/presentation/cubit/verify_email_otp_cubit.dart';
import 'package:drugs_ng/src/features/auth/presentation/pages/confirmation_page.dart';
import 'package:drugs_ng/src/core/utils/app_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final password1Cntrl = TextEditingController();
  final password2Cntrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscurePassword1 = true;
  bool obscurePassword2 = true;

  @override
  void dispose() {
    password1Cntrl.dispose();
    password2Cntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyEmailOtpCubit(context.read<AuthRepository>()),
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
                  suffixIcon: svgPicture(obscurePassword1),
                  obscureText: obscurePassword1,
                  clickSuffix: _toggleVisibility1,
                  validator: AppValidators.password,
                ),
                22.verticalSpace,
                AppText.sp14("Confirm new password").w400.black,
                6.verticalSpace,
                AppTextField.text(
                  controller: password2Cntrl,
                  hint: "Must be 8 characters",
                  keyboardType: TextInputType.text,
                  suffixIcon: svgPicture(obscurePassword2),
                  obscureText: obscurePassword2,
                  clickSuffix: _toggleVisibility2,
                  validator: (v) {
                    if (password1Cntrl.text != v) {
                      return "Password must be same";
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
        colorFilter: const ColorFilter.mode(
          AppColor.darkGrey,
          BlendMode.srcIn,
        ),
      );

  void _toggleVisibility1() {
    setState(() => obscurePassword1 = !obscurePassword1);
  }

  void _toggleVisibility2() {
    setState(() => obscurePassword2 = !obscurePassword2);
  }

  void _back() {
    Navigator.of(context).pop();
  }

  void _resetPassword(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.read<ResetPasswordCubit>().resetPassword(
            password1Cntrl.text,
            "",
          );
    }
  }

  void _backToLogin() {
    AppUtils.navKey.currentState?.popUntil((route) => route.isFirst);
  }
}
