import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreCategoryWidget extends StatelessWidget {
  final String img;
  final String title;
  final String subtitle;
  final void Function() onTap;

  const ExploreCategoryWidget({
    super.key,
    required this.img,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: const Color(0xFFEAEFF5),
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Row(
          children: [
            Container(
              width: 95.r,
              height: 95.r,
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Image.asset(img),
            ),
            15.horizontalSpace,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.sp16(title).w500.black,
                  2.verticalSpace,
                  AppText.sp14(subtitle)
                      .w400
                      .setColor(const Color(0xFF8B96A5))
                      .setMaxLines(3),
                ],
              ),
            ),
            10.horizontalSpace,
            RotatedBox(
              quarterTurns: 3,
              child: SvgPicture.asset(
                AppSvg.chevronLight,
                width: 20.w,
                colorFilter: const ColorFilter.mode(
                  AppColor.darkGrey,
                  BlendMode.srcIn,
                ),
              ),
            ),
            5.horizontalSpace,
          ],
        ),
      ),
    );
  }
}
