import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButton {
  static Widget primary(
      {required String text, required void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 58.h,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
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

  static Widget secondary(
      {required String text, required void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 58.h,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.whiteBlue,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
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

  static Widget svgIcon(
      {required String svg, required Function() onTap, Color? color}) {
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
}
