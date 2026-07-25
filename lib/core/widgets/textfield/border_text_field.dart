import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BorderTextField extends StatelessWidget {
  const BorderTextField({
    super.key,
    this.hint,
    this.focusNode,
    this.controller,
    this.autofocus = false,
    this.obscureText = false,
    this.keyboardType,
    this.prefix,
    this.suffixIcon,
    this.validator,
    this.clickSuffix,
    this.enabled,
    this.onTap,
    this.fillColor,
    this.filled = false,
    this.borderColor = AppColor.colorBDC4CD,
    this.borderRadius,
    this.readOnly,
  });

  final String? hint;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool autofocus;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefix;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function()? clickSuffix;
  final bool? enabled;
  final void Function()? onTap;
  final Color? fillColor;
  final bool filled;
  final Color borderColor;
  final double? borderRadius;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      autofocus: autofocus,
      obscureText: obscureText,
      keyboardType: keyboardType,
      enabled: enabled,
      readOnly: readOnly ?? onTap != null,
      onTap: onTap,
      style: TextStyle(
        fontSize: 16.sp,
        color: AppColor.color1A1D26,
        fontWeight: FontWeight.w500,
      ),
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        fillColor: fillColor,
        filled: filled,
        hintStyle: TextStyle(
          fontSize: 15.sp,
          color: AppColor.color6D6D6D,
          fontWeight: FontWeight.w400,
        ),
        errorStyle: TextStyle(
          color: AppColor.colorDC2626,
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
        ),
        prefix: prefix,
        suffixIcon:
            suffixIcon == null
                ? null
                : InkWell(
                  onTap: clickSuffix,
                  child: Container(
                    width: 50.r,
                    alignment: Alignment.center,
                    child: suffixIcon,
                  ),
                ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
          borderSide: BorderSide(color: borderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
          borderSide: const BorderSide(color: AppColor.colorDC2626),
        ),
        errorMaxLines: 4,
      ),
    );
  }
}
