import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorRatingChip extends StatelessWidget {
  const DoctorRatingChip({super.key, required this.rating});

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.r),
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 5.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: const Color(0xFFF3FFF4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 16.r,
            width: 16.r,
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B),
              borderRadius: BorderRadius.circular(2.r),
            ),
            alignment: Alignment.center,
            child: CustomImage(
              AppSvg.starFilled,
              color: AppColor.white,
              width: 12.r,
              height: 12.r,
            ),
          ),
          4.horizontalSpace,
          AppText.sp10(rating.round().toString()),
        ],
      ),
    );
  }
}
