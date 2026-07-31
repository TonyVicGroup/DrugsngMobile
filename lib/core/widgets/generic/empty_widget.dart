import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.svg,
    required this.buttonText,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String svg;
  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColor.colorFFFFFF,
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImage(svg, width: 91.r, color: AppColor.color8B96A5),
              27.verticalSpace,
              AppText.sp30(title).w500.setColor(AppColor.color333333),
              13.verticalSpace,
              AppText.sp16(
                subtitle,
              ).w400.centerText.setColor(AppColor.color6D6D6D),
              10.verticalSpace,
              AppGradientButton(text: buttonText, onTap: onTap),
            ],
          ),
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}
