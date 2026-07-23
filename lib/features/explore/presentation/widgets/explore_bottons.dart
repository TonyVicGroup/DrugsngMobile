import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplyButton extends StatelessWidget {
  final String label;
  final void Function() onTap;

  const ApplyButton({super.key, this.label = "Apply", required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 191.w,
        height: 36.sp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: AppText.sp14(label).w700.white,
      ),
    );
  }
}

class DiscardButton extends StatelessWidget {
  final void Function() onTap;
  const DiscardButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 191.w,
        height: 36.sp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(color: AppColor.black),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: AppText.sp14("Discard").w700.black,
      ),
    );
  }
}
