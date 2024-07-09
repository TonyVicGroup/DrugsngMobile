import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSubmitted;

  const ExploreSearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49.h,
      width: 398.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(5.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(0.05),
              offset: const Offset(0, 4),
              blurRadius: 8,
            )
          ]),
      child: Theme(
        data: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            constraints: BoxConstraints(maxWidth: 398.w, maxHeight: 49.h),
            fillColor: AppColor.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: AppColor.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: AppColor.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: AppColor.white),
            ),
          ),
        ),
        child: TextField(
          cursorHeight: 30.h,
          controller: controller,
          cursorColor: AppColor.lightGrey,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.all(13.r),
              child: SvgPicture.asset(
                AppSvg.search,
                colorFilter: const ColorFilter.mode(
                  AppColor.lightGrey,
                  BlendMode.srcIn,
                ),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            hintText: "Search",
            hintStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF8B96A5),
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
