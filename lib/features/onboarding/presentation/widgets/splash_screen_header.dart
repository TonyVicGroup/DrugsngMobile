import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreenHeader extends StatelessWidget {
  const SplashScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomImage(Assets.images.splashLogo.path, width: 107.w),

        18.verticalSpace,
        CustomImage(
          Assets.svg.shieldCheck,
          color: AppColor.color0B8AE1,
          width: 24.w,
          height: 24.h,
          fit: BoxFit.fill,
        ),
        10.verticalSpace,
        AppText.sp12(
          'Trusted Healthcare. Anytime. Anywhere',
        ).w400.setColor(AppColor.color555555),
      ],
    );
  }
}
