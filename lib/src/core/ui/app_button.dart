import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButton {
  static Widget primary({
    required String text,
    required void Function()? onTap,
    ButtonStatus status = ButtonStatus.active,
  }) {
    return InkWell(
      onTap: status.isActive ? onTap : null,
      child: Container(
        height: 58.h,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: status.isLoading
            ? _loader()
            : Text(
                text,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.white,
                ),
              ),
      ),
    );
  }

  static Widget secondary({
    required String text,
    required void Function()? onTap,
    ButtonStatus status = ButtonStatus.active,
  }) {
    return InkWell(
      onTap: status.isActive ? onTap : null,
      child: Container(
        height: 58.h,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.whiteBlue,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: status.isLoading
            ? _loader(AppColor.primary)
            : Text(
                text,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.primary,
                ),
              ),
      ),
    );
  }

  static Widget svgIcon({
    required String svg,
    required Function() onTap,
    Color? color,
    ButtonStatus status = ButtonStatus.active,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 30.h,
        height: 30.h,
        alignment: Alignment.center,
        padding: EdgeInsets.all(7.r),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFEAEFF5),
        ),
        child: SvgPicture.asset(
          svg,
          colorFilter:
              color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
    );
  }

  static Widget roundedBack(void Function() onTap) => InkWell(
        onTap: onTap,
        child: Container(
          height: 39.h,
          width: 39.w,
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColor.lightGrey),
          ),
          child: SvgPicture.asset(
            AppSvg.chevronThick,
          ),
        ),
      );

  static Widget _loader([Color color = AppColor.white]) => SizedBox(
        height: 30.r,
        width: 30.r,
        child: CircularProgressIndicator(
          color: color,
          strokeCap: StrokeCap.round,
        ),
      );
}
