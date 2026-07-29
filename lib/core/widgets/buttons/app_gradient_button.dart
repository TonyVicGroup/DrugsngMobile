import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppGradientButton extends StatelessWidget {
  factory AppGradientButton({
    required String text,
    required void Function() onTap,
    FontWeight fontWeight = FontWeight.w500,
    ButtonStatus status = ButtonStatus.active,
    double? fontSize,
    double? height,
    double? width,
  }) {
    return AppGradientButton._(
      onTap: onTap,
      status: status,
      height: height,
      width: width,
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
    );
  }

  const AppGradientButton._({
    required this.onTap,
    required this.status,
    required this.child,
    this.height,
    this.width,
  });

  factory AppGradientButton.widget({
    required void Function() onTap,
    required Widget child,
    ButtonStatus status = ButtonStatus.active,
    double? height,
    double? width,
  }) {
    return AppGradientButton._(
      onTap: onTap,
      status: status,
      height: height,
      width: width,
      child: child,
    );
  }

  factory AppGradientButton.suffixIcon({
    required String text,
    required String svg,
    required void Function() onTap,
    FontWeight fontWeight = FontWeight.w500,
    ButtonStatus status = ButtonStatus.active,
    double? fontSize,
    double? svgWidth,
    double? svgHeight,
    double? height,
    double? width,
  }) {
    return AppGradientButton._(
      onTap: onTap,
      status: status,
      height: height,
      width: width,
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
              : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize ?? 16.sp,
                      fontWeight: fontWeight,
                      color: AppColor.colorFFFFFF,
                    ),
                  ),
                  10.horizontalSpace,
                  CustomImage(
                    svg,
                    width: svgWidth ?? 18.r,
                    height: svgHeight ?? 18.r,
                    color: AppColor.colorFFFFFF,
                  ),
                ],
              ),
    );
  }

  factory AppGradientButton.prefixIcon({
    required String text,
    required String svg,
    required void Function() onTap,
    FontWeight fontWeight = FontWeight.w500,
    ButtonStatus status = ButtonStatus.active,
    double? fontSize,
    double? svgWidth,
    double? svgHeight,
    double? width,
    double? height,
    double? spacer,
  }) {
    return AppGradientButton._(
      onTap: onTap,
      status: status,
      height: height,
      width: width,
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
              : Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImage(
                    svg,
                    width: svgWidth ?? 18.r,
                    height: svgHeight ?? 18.r,
                    color: AppColor.colorFFFFFF,
                  ),
                  SizedBox(width: spacer ?? 10.w),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize ?? 16.sp,
                      fontWeight: fontWeight,
                      color: AppColor.colorFFFFFF,
                    ),
                  ),
                ],
              ),
    );
  }

  final void Function() onTap;
  final ButtonStatus status;
  final Widget child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return AppButtonAnimator(
      enabled: status.isActive,
      onTap: onTap,
      child: Container(
        height: height ?? 51.h,
        width: width ?? double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: status.isDisabled ? AppColor.colorC5CDD8 : null,
          borderRadius: BorderRadius.circular(100.r),
          gradient:
              status.isDisabled
                  ? null
                  : LinearGradient(
                    colors: [const Color(0xFF0D5CC2), const Color(0xFF00D6EF)],
                  ),
        ),
        child: child,
      ),
    );
  }
}
