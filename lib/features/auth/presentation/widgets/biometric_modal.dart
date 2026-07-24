import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/buttons/app_text_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/login_cubit.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BiometricModal extends StatelessWidget {
  const BiometricModal({super.key});

  static Future<void> show(BuildContext context) async {
    return context.showPopup(const BiometricModal());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 387.w,
        height: 495.h,
        padding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 29.h),
        decoration: BoxDecoration(
          color: AppColor.colorFFFFFF,
          borderRadius: BorderRadius.all(Radius.circular(30.r)),
          boxShadow: AppColor.shadow,
        ),
        child: Column(
          children: [
            Container(
              width: 91.r,
              height: 91.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.color0B8AE1,
                boxShadow: AppColor.blueShadow,
                border: Border.all(color: AppColor.color00C3EF.withAlpha(150)),
              ),
              child: CustomImage(
                Assets.svg.biometric,
                color: AppColor.colorFFFFFF,
                width: 49.r,
                height: 49.r,
              ),
            ),
            const Spacer(),
            AppText.sp25(
              'Enable Biometric Login',
            ).w600.setColor(AppColor.color333333).centerText,
            25.verticalSpace,
            AppText.sp16(
                  'Login in instantly with Face ID or Touch ID '
                  'without typing your password everytime.',
                ).w400
                .setColor(AppColor.color333333)
                .setLineHeight(1.25)
                .centerText,
            25.verticalSpace,
            rowInfo(Assets.svg.lightning, 'Faster & more convenient'),
            5.verticalSpace,
            rowInfo(Assets.svg.shieldCheck, 'More secure than passwords'),
            const Spacer(),
            AppGradientButton(
              text: 'Setup Biometric Now',
              onTap: () => _setupBiometric(context),
            ),
            20.verticalSpace,
            AppTextButton(
              text: 'Maybe Later',
              onTap: () => _maybeLater(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowInfo(String svg, String text) {
    return Row(
      children: [
        CustomImage(
          svg,
          width: 20.r,
          height: 20.r,
          color: AppColor.color0B8AE1,
        ),
        6.horizontalSpace,
        AppText.sp16(
          text,
        ).w500.setColor(AppColor.color333333).setLineHeight(1.25),
      ],
    );
  }

  void _setupBiometric(BuildContext context) {
    context.pop();
    context.read<LoginCubit>().setupBiometric();
    AppToast.success(
      context,
      'Biometric Login enabled. Please login to confirm setup',
    );
  }

  void _maybeLater(BuildContext context) {
    context.pop();
  }
}
