import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/diagnostic_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiagnosticTestWidget extends StatelessWidget {
  final DiagnosticTest test;
  const DiagnosticTestWidget({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 192.w,
      height: 225.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
              color: AppColor.black.withOpacity(0.04),
              offset: const Offset(0, 4),
              blurRadius: 20),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50.r,
            height: 50.r,
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.primary.withOpacity(0.1),
            ),
            child: Image.asset(test.icon),
          ),
          AppText.sp16(test.title).w700.black,
          AppText.sp12(test.text).w400.darkGrey,
          Container(
            height: 35.h,
            width: double.maxFinite,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: AppColor.primary,
            ),
            child: AppText.sp14("Book Now").w700.white,
          )
        ],
      ),
    );
  }
}
