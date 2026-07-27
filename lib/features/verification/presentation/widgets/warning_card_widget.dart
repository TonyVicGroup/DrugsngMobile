import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WarningCardWidget extends StatelessWidget {
  const WarningCardWidget({
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
          CustomImage(
            Assets.svg.warnTriangle,
            width: 20.r,
            height: 20.r,
            color: AppColor.colorD97706,
          ),
          12.horizontalSpace,
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: subtitle),
                ],
                style: TextStyle(
                  color: AppColor.color92400E,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
