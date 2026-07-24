import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppGradientButton extends StatelessWidget {
  const AppGradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.fontWeight = FontWeight.w500,
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
      enabled: status.isActive,
      onTap: onTap,
      child: Container(
        height: 51.h,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: status.isDisabled ? AppColor.lightBlue : AppColor.primary,
          borderRadius: BorderRadius.circular(100.r),
          gradient: LinearGradient(
            colors: [const Color(0xFF0D5CC2), const Color(0xFF00D6EF)],
          ),
        ),
        child:
            status.isLoading
                ? SizedBox(
                  height: 30.r,
                  width: 30.r,
                  child: CircularProgressIndicator(
                    color: AppColor.colorFFFFFF,
                    strokeCap: StrokeCap.round,
                  ),
                )
                : Text(
                  text,
                  style: TextStyle(
                    fontSize: fontSize ?? 16.sp,
                    fontWeight: fontWeight,
                    color: AppColor.colorFFFFFF,
                  ),
                ),
      ),
    );
  }
}
