import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppTextField {
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
                colorFilter:
                    const ColorFilter.mode(Color(0xFF6D6D6D), BlendMode.srcIn),
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Color(0xFFBDC4CD)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Color(0xFFBDC4CD)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: const BorderSide(color: Color(0xFFBDC4CD)),
          ),
        ),
      );
}
