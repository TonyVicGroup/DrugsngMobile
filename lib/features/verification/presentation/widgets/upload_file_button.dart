import 'package:dotted_border/dotted_border.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadFileButton extends StatelessWidget {
  const UploadFileButton({
    required this.svg,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });
  final String svg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppButtonAnimator(
      onTap: onTap,
      animationOffset: 0.99,
      child: DottedBorder(
        radius: Radius.circular(16.r),
        dashPattern: [6, 4],
        borderType: BorderType.RRect,
        strokeWidth: 2,
        color: AppColor.colorE0E0E0,

        child: SizedBox(
          width: double.maxFinite,
          height: 199.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60.r,
                height: 60.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.color0B8AE1.withAlpha(25),
                ),
                child: CustomImage(
                  svg,
                  width: 24.r,
                  height: 24.r,
                  color: AppColor.color0B8AE1,
                ),
              ),
              8.verticalSpace,
              AppText.sp14(
                title,
              ).w600.setColor(AppColor.color666666).centerText,
              8.verticalSpace,
              AppText.sp12(
                subtitle,
              ).w400.setColor(AppColor.color999999).centerText,
              8.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
