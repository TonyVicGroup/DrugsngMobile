import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashButtonWidget extends StatelessWidget {
  const SplashButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 34.r,
          height: 34.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.colorFFFFFF,
            boxShadow: AppColor.shadow,
          ),
          child: CustomImage(Assets.svg.shieldCheck, width: 20.w, height: 20.h),
        ),
        10.verticalSpace,
        AppText.sp13(
          'Your health. Our Priority',
        ).w400.centerText.setColor(AppColor.color555555),
      ],
    );
  }
}
