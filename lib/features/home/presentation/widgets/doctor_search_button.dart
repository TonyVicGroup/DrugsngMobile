import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorSearchButton extends StatelessWidget {
  const DoctorSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19.h),
        border: Border.all(color: const Color(0xFFD5D5D5)),
        color: const Color(0xFFF5F6FA),
      ),
      child: Row(
        children: [
          CustomImage(AppSvg.search, width: 15.r, height: 15.r),
          10.horizontalSpace,
          AppText.sp14('Search').w400.setColor(const Color(0xFF212B36)),
        ],
      ),
    );
  }
}
