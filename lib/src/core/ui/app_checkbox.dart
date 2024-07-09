import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppCheckbox {
  static Widget primary({
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
        width: 18.r,
        height: 18.r,
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.r),
          color: value ? AppColor.primary : null,
          border: value ? null : Border.all(color: const Color(0xFF8B96A5)),
        ),
        child: SvgPicture.asset(
          AppSvg.checkMark,
          colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}
