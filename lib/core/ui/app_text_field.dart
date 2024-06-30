import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppTextField {
  static TextFormField text({
    String? hint,
    FocusNode? focusNode,
    TextEditingController? controller,
    bool autofocus = false,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? prefix,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    void Function()? clickSuffix,
  }) =>
      TextFormField(
        focusNode: focusNode,
        controller: controller,
        autofocus: autofocus,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColor.black,
          fontWeight: FontWeight.w500,
        ),
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 16.sp,
            color: AppColor.darkGrey,
            fontWeight: FontWeight.w400,
          ),
          errorStyle: TextStyle(
            color: AppColor.red,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          prefix: prefix,
          suffixIcon: suffixIcon == null
              ? null
              : InkWell(
                  onTap: clickSuffix,
                  child: Container(
                    width: 50.r,
                    alignment: Alignment.center,
                    child: suffixIcon,
                  ),
                ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: AppColor.lightGrey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: AppColor.lightGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: AppColor.lightGrey),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: AppColor.red),
          ),
          errorMaxLines: 4,
        ),
      );

  static TextField search({required String hint, required Function() onTap}) =>
      TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 18.sp,
            color: const Color(0xFFBDC4CD),
          ),
          suffixIcon: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(18.r),
              child: SvgPicture.asset(
                AppSvg.search,
                colorFilter: const ColorFilter.mode(
                  AppColor.darkGrey,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: AppColor.lightGrey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: AppColor.lightGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: AppColor.lightGrey),
          ),
        ),
      );
}
