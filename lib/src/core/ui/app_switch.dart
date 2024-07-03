import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSwitch {
  static Widget black({
    required bool value,
    void Function(bool)? onChanged,
  }) {
    return InkWell(
      onTap: onChanged == null
          ? null
          : () {
              onChanged(!value);
            },
      child: Container(
        width: 44.w,
        height: 26.h,
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
        decoration: BoxDecoration(
          color: value ? AppColor.black : AppColor.darkGrey,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 500),
          alignment: Alignment(value ? 1 : -1, 0),
          child: Container(
            width: 20.r,
            height: 20.r,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.white,
            ),
          ),
        ),
      ),
    );
  }
}
