import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/textfield/app_text_field.dart';
// import 'package:drugs_ng/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/verify_email_otp_cubit.dart';
import 'package:drugs_ng/features/auth/presentation/pages/confirmation_page.dart';
import 'package:drugs_ng/core/utils/app_validators.dart';
import 'package:drugs_ng/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, required this.otp, required this.email});
  final String otp;
  final String email;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final password1Cntrl = TextEditingController();
  final password2Cntrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ValueNotifier<bool> obscurePassword1 = ValueNotifier(true);
  ValueNotifier<bool> obscurePassword2 = ValueNotifier(true);

  @override
  void dispose() {
    password1Cntrl.dispose();
    password2Cntrl.dispose();
    obscurePassword1.dispose();
    obscurePassword2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              AppText.sp16(
                "Do well to type what you'll remember",
              ).w400.darkGrey,
              40.verticalSpace,
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
              40.verticalSpace,
              const Spacer(),
              BlocConsumer<EmailOtpCubit, EmailOtpState>(
                listenWhen: (_, __) => context.isOnScreen,
                listener: (context, state) {
                  if (state.status.isSuccess) {
                    Navigator.push(
                      context,
                      AppUtils.transition(
                        ConfirmationPage(
                          title: "Password changed",
                          subtitle:
                              "Great! Your password has been changed successfully.",
                          btnText: "Back to login",
                          onTap: _backToLogin,
                        ),
                      ),
                    );
                  }
                  if (state.status.isFailed) {
                    AppToast.warn(context, state.error!.message);
                  }
                },
                builder: (context, state) {
                  return MultiValueListenableBuilder(
                    valueListenables: [password1Cntrl, password2Cntrl],
                    builder: (context, value, child) {
                      return AppButton.primary(
                        text: "Reset password",
                        onTap: () => _resetPassword(context),
                        status:
                            state.status.isLoading
                                ? ButtonStatus.loading
                                : (buttonEnabled
                                    ? ButtonStatus.active
                                    : ButtonStatus.disabled),
                      );
                    },
                  );
                },
              ),
              54.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  bool get buttonEnabled {
    return password1Cntrl.text.isNotEmpty && password2Cntrl.text.isNotEmpty;
  }

  Widget svgPicture(bool visible) => SvgPicture.asset(
    visible ? AppSvg.visible : AppSvg.notVisible,
    width: 17.w,
    colorFilter: const ColorFilter.mode(AppColor.darkGrey, BlendMode.srcIn),
  );

  void _back() => Navigator.of(context).pop();

  void _resetPassword(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.read<EmailOtpCubit>().confirmOtp(
        otp: widget.otp,
        password: password1Cntrl.text,
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
