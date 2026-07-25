import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColor.colorF5F7FA,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.color0B8AE1.withAlpha(25),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: CustomImage(
              Assets.svg.shieldOutline,
              width: 20.r,
              height: 20.r,
              color: AppColor.color0B8AE1,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.sp14(title).w600.setColor(AppColor.color333333),
                3.99.verticalSpace,
                AppText.sp13(subtitle).w600.setColor(AppColor.color666666),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
