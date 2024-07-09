import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppRadio {
  static Widget circle({required bool value, void Function(bool)? onChanged}) {
    return InkWell(
      onTap: onChanged == null
          ? null
          : () {
              onChanged(!value);
            },
      child: Container(
        width: 21.r,
        height: 21.r,
        padding: EdgeInsets.all(2.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: value ? AppColor.primary : const Color(0xFF8B96A5),
          ),
        ),
        child: value
            ? Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primary,
                ),
              )
            : null,
      ),
    );
  }
}
