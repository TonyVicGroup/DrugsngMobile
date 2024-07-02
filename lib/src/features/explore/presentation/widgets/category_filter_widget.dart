import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryFilterWidget extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const CategoryFilterWidget({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFEAEFF5),
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: const Color(0xFF8B96A5)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.sp11(text).w400.setColor(const Color(0xFF8B96A5)),
            5.horizontalSpace,
            SvgPicture.asset(
              AppSvg.close,
              colorFilter:
                  const ColorFilter.mode(Color(0xFFBDC4CD), BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
