import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.fontWeight = FontWeight.w400,
    this.status = ButtonStatus.active,
    this.fontSize,
  });

  final String text;
  final void Function() onTap;
  final double? fontSize;
  final FontWeight? fontWeight;
  final ButtonStatus status;

  @override
  Widget build(BuildContext context) {
    return AppButtonAnimator(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? 17.sp,
            fontWeight: fontWeight,
            color: AppColor.color666666,
          ),
        ),
      ),
    );
  }
}
