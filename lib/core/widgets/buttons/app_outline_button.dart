import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppOutlineButton extends StatelessWidget {
  factory AppOutlineButton({
    required String text,
    required void Function() onTap,
    FontWeight fontWeight = FontWeight.w500,
    ButtonStatus status = ButtonStatus.active,
    Color foregroundColor = AppColor.color333333,
    double? fontSize,
    Color fillColor = AppColor.colorF5F7FA,
    Color borderColor = AppColor.colorE0E0E0,
    double? borderRadius,
    double? width,
    double? height,
  }) {
    return AppOutlineButton._(
      onTap: onTap,
      status: status,
      fillColor: fillColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      width: width,
      height: height,
      child:
          status.isLoading
              ? _loader(foregroundColor)
              : Text(
                text,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: foregroundColor,
                ),
              ),
    );
  }

  const AppOutlineButton._({
    required this.onTap,
    required this.status,
    required this.borderColor,
    required this.fillColor,
    required this.child,
    required this.borderRadius,
    required this.width,
    required this.height,
    super.key,
  });

  factory AppOutlineButton.widget({
    required void Function() onTap,
    required Widget child,
    ButtonStatus status = ButtonStatus.active,
    Color fillColor = AppColor.colorF5F7FA,
    Color borderColor = AppColor.colorE0E0E0,
    double? borderRadius,
    double? width,
    double? height,
  }) {
    return AppOutlineButton._(
      onTap: onTap,
      status: status,
      fillColor: fillColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      width: width,
      height: height,
      child: child,
    );
  }

  factory AppOutlineButton.suffixIcon({
    required String text,
    required String svg,
    required void Function() onTap,
    FontWeight fontWeight = FontWeight.w500,
    ButtonStatus status = ButtonStatus.active,
    double? fontSize,
    double? svgWidth,
    double? svgHeight,
    Color fillColor = AppColor.colorF5F7FA,
    Color borderColor = AppColor.colorE0E0E0,
    double? borderRadius,
    double? width,
    double? height,
  }) {
    return AppOutlineButton._(
      onTap: onTap,
      status: status,
      fillColor: fillColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      width: width,
      height: height,
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

  factory AppOutlineButton.prefixIcon({
    required String text,
    required String svg,
    required void Function() onTap,
    FontWeight fontWeight = FontWeight.w500,
    ButtonStatus status = ButtonStatus.active,
    double? fontSize,
    double? svgWidth,
    double? svgHeight,
    Color fillColor = AppColor.colorF5F7FA,
    Color borderColor = AppColor.colorE0E0E0,
    double? borderRadius,
    double? width,
    double? height,
  }) {
    return AppOutlineButton._(
      onTap: onTap,
      status: status,
      fillColor: fillColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      width: width,
      height: height,
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
                  CustomImage(
                    svg,
                    width: svgWidth ?? 18.r,
                    height: svgHeight ?? 18.r,
                    color: AppColor.colorFFFFFF,
                  ),
                  10.horizontalSpace,
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
  final Color fillColor;
  final Color borderColor;
  final Widget child;
  final double? borderRadius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return AppButtonAnimator(
      onTap: onTap,
      child: Container(
        height: height ?? 52.h,
        width: width ?? double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          border: Border.all(color: borderColor, width: 1.r),
        ),
        child: child,
      ),
    );
  }

  static Widget _loader([Color color = AppColor.white]) => SizedBox(
    height: 30.r,
    width: 30.r,
    child: CircularProgressIndicator(color: color, strokeCap: StrokeCap.round),
  );
}
