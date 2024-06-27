import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
}
