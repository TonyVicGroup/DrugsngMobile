import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          onChanged == null
              ? null
              : () {
                onChanged!(!value);
              },
      child: Container(
        width: 44.w,
        height: 26.h,
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
        decoration: BoxDecoration(
          color: value ? AppColor.color0B8AE1 : AppColor.color9CA3AF,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.bounceInOut,
          alignment: Alignment(value ? 1 : -1, 0),
          child: Container(
            width: 20.r,
            height: 20.r,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.colorFFFFFF,
            ),
          ),
        ),
      ),
    );
  }
}
