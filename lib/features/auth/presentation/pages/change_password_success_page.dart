import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/navigation/app_route.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChangePasswordSuccessPage extends StatelessWidget {
  const ChangePasswordSuccessPage({super.key});

  static Route<dynamic> route(RouteSettings settings) => MaterialPageRoute(
    builder: (_) => const ChangePasswordSuccessPage(),
    settings: settings,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColor.colorFFFFFF,
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: AppColor.shadow,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                10.verticalSpace,
                CustomImage(Assets.svg.greenSquareCheck, width: 111.w),
                21.verticalSpace,
                AppText.sp30(
                  "Password Changed",
                ).w500.setColor(AppColor.color333333),
                13.verticalSpace,
                AppText.sp16(
                  "Great! Your password has been changed successfully.",
                ).w400.setColor(AppColor.color6D6D6D).centerText,
                21.verticalSpace,
                AppGradientButton(
                  text: "Back to Login",
                  onTap: () => _saveNewPassword(context),
                ),
                14.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveNewPassword(BuildContext context) {
    // if (formKey.currentState?.validate() ?? false) {
    //   context.read<ForgetPasswordCubit>().sendPasswordReset(emailCntrl.text);
    // }
    context.pushNamed(AppRoutes.selectAccountType);
  }

  Widget svgPicture(bool visible) => SvgPicture.asset(
    visible ? Assets.svg.visible : Assets.svg.nonVisible,
    width: 17.w,
    colorFilter: const ColorFilter.mode(AppColor.color6D6D6D, BlendMode.srcIn),
  );
}
