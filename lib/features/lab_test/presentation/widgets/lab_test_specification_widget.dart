import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LabTestSpecificationWidget extends StatelessWidget {
  final String info1;
  final String title1;
  final String info2;
  final String title2;
  final String info3;
  final String title3;
  const LabTestSpecificationWidget({
    super.key,
    required this.info1,
    required this.title1,
    required this.info2,
    required this.title2,
    required this.info3,
    required this.title3,
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
          _info(AppSvg.syringe, info1, title1),
          _divider(),
          _info(AppSvg.calendarSchedule, info2, title2),
          _divider(),
          _info(AppSvg.listChecked, info3, title3),
        ],
      ),
    );
  }

  Container _divider() =>
      Container(height: 44.h, width: 1, color: const Color(0xFFBDC4CD));

  Expanded _info(String svg, String value, String title) {
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
            svg,
            width: 22.r,
            colorFilter: const ColorFilter.mode(
              AppColor.primary,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}
