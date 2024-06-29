import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/ui/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationChip extends StatelessWidget {
  const LocationChip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      height: 30.h,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.r),
        color: const Color(0xFFEAEFF5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppSvg.location,
            colorFilter:
                const ColorFilter.mode(AppColor.black, BlendMode.srcIn),
          ),
          8.horizontalSpace,
          Expanded(
            child: AppText.sp14("Ikeja, Lagos").w300.black.setMaxLines(1),
          ),
        ],
      ),
    );
  }
}
