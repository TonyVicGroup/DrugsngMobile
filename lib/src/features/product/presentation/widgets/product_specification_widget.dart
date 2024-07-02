import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductSpecificationWidget extends StatelessWidget {
  const ProductSpecificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.r),
        border: Border.all(color: AppColor.lightGrey),
      ),
      child: Row(
        children: [
          _info("Syrup", "Form"),
          _divider(),
          _info("118mL", "Size"),
          _divider(),
          _info("1", "Quantity"),
        ],
      ),
    );
  }

  Container _divider() => Container(
        height: 44.h,
        width: 1,
        color: const Color(0xFFBDC4CD),
      );

  Expanded _info(String value, String title) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.sp16(value).w700.setColor(const Color(0xFF6D6D6D)),
              7.verticalSpace,
              AppText.sp12(title).w400.setColor(const Color(0xFF8B96A5)),
            ],
          ),
          15.horizontalSpace,
          SvgPicture.asset(
            AppSvg.chevronLight,
            width: 16.r,
            colorFilter:
                const ColorFilter.mode(Color(0xFF6D6D6D), BlendMode.srcIn),
          )
        ],
      ),
    );
  }
}
