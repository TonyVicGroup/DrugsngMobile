import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBackButton {
  static Widget light(void Function() onTap) => AppButtonAnimator(
    onTap: onTap,
    child: Container(
      height: 39.r,
      width: 39.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColor.colorBDC4CD),
        color: AppColor.colorFFFFFF,
      ),
      child: SvgPicture.asset(
        Assets.svg.chevronLeft,
        colorFilter: ColorFilter.mode(AppColor.color333333, BlendMode.srcIn),
        height: 15.h,
      ),
    ),
  );

  static Widget grey(void Function() onTap) => AppButtonAnimator(
    onTap: onTap,
    child: Container(
      height: 40.r,
      width: 40.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColor.colorF5F7FA),
      ),
      child: CustomImage(
        Assets.svg.arrowLeft,
        width: 20.r,
        height: 20.r,
        color: AppColor.color666666,
      ),
    ),
  );
}
