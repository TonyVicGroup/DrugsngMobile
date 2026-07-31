import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget._({
    required this.title,
    required this.subtitle,
    required this.svg,
    required this.buttonText,
    required this.onTap,
    required this.isShrinked,
  });

  final String title;
  final String subtitle;
  final String svg;
  final String buttonText;
  final VoidCallback? onTap;
  final bool isShrinked;

  factory EmptyWidget({
    required String title,
    required String subtitle,
    required String svg,
    required String buttonText,
    VoidCallback? onTap,
  }) {
    return EmptyWidget._(
      title: title,
      subtitle: subtitle,
      svg: svg,
      buttonText: buttonText,
      onTap: onTap,
      isShrinked: false,
    );
  }

  factory EmptyWidget.shrinked({
    required String title,
    required String subtitle,
    required String svg,
    required String buttonText,
    VoidCallback? onTap,
  }) {
    return EmptyWidget._(
      title: title,
      subtitle: subtitle,
      svg: svg,
      buttonText: buttonText,
      onTap: onTap,
      isShrinked: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: isShrinked ? MainAxisSize.min : MainAxisSize.max,
      children: [
        if (!isShrinked) const Spacer(flex: 2),
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
              if (onTap != null)
                AppGradientButton(text: buttonText, onTap: onTap!),
            ],
          ),
        ),
        if (!isShrinked) const Spacer(flex: 3),
      ],
    );
  }
}
