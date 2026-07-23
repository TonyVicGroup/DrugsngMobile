import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    bool? enabled,
    void Function()? onTap,
  }) => TextFormField(
    focusNode: focusNode,
    controller: controller,
    autofocus: autofocus,
    obscureText: obscureText,
    keyboardType: keyboardType,
    enabled: enabled,
    onTap: onTap,
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

  static Widget search({required String hint, required Function() onTap}) =>
      InkWell(
        onTap: onTap,
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 18.h,
            ),
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFBDC4CD),
            ),
            suffixIcon: Container(
              width: 50.w,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                AppSvg.search,
                width: 20.r,
                height: 20.r,
                colorFilter: const ColorFilter.mode(
                  AppColor.darkGrey,
                  BlendMode.srcIn,
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
        ),
      );

  static Widget grey({
    String? hint,
    String? labelText,
    FocusNode? focusNode,
    TextEditingController? controller,
    bool autofocus = false,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? prefix,
    Widget? suffixIcon,
    String? Function()? validator,
    bool enabled = true,
    void Function()? onTap,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return FormField(
      validator: validator != null ? (v) => validator() : null,
      builder: (state) {
        String? errorText = state.errorText;
        final Color borderColor =
            errorText != null ? AppColor.red : const Color(0xFFEAEFF5);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: enabled ? null : onTap,
              child: Container(
                height: 56.h,
                padding: EdgeInsets.symmetric(vertical: 11.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAEFF5),
                  border: Border.all(color: borderColor),
                ),
                child: Theme(
                  data: ThemeData(
                    inputDecorationTheme: InputDecorationTheme(
                      constraints: BoxConstraints(maxHeight: 33.h),
                      fillColor: const Color(0xFF8B96A5),
                      focusColor: const Color(0xFF8B96A5),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      labelStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF8B96A5),
                      ),

                      // border: InputBorder.none
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(color: Color(0xFFEAEFF5)),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(color: Color(0xFFEAEFF5)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(color: Color(0xFFEAEFF5)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(color: Color(0xFFEAEFF5)),
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    cursorHeight: 20.h,
                    keyboardType: keyboardType,
                    autofocus: autofocus,
                    obscureText: obscureText,
                    enabled: enabled,
                    cursorColor: AppColor.darkGrey,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.black,
                    ),
                    decoration: InputDecoration(
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      labelText: labelText,
                      hintText: hint,
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF8B96A5),
                      ),
                    ),
                    inputFormatters: inputFormatters,
                  ),
                ),
              ),
            ),
            if (errorText != null) ...[
              AppText.sp12(errorText).w400.setColor(AppColor.red),
            ],
          ],
        );
      },
    );
  }

  static Widget greyDropdown<T>({
    String? hint,
    String? labelText,
    T? selectedValue,
    required List<T> options,
    String? Function()? validator,
    bool enabled = true,
    void Function(T?)? onChanged,
    List<TextInputFormatter>? inputFormatters,
    bool showIcon = false,
  }) {
    return FormField(
      validator: validator != null ? (v) => validator() : null,
      builder: (state) {
        String? errorText = state.errorText;
        final Color borderColor =
            errorText != null ? AppColor.red : const Color(0xFFEAEFF5);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 56.h,
              padding: EdgeInsets.symmetric(vertical: 11.h),
              decoration: BoxDecoration(
                color: const Color(0xFFEAEFF5),
                border: Border.all(color: borderColor),
              ),
              child: Theme(
                data: ThemeData(
                  inputDecorationTheme: InputDecorationTheme(
                    constraints: BoxConstraints(maxHeight: 33.h),
                    fillColor: const Color(0xFF8B96A5),
                    focusColor: const Color(0xFF8B96A5),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    labelStyle: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF8B96A5),
                    ),

                    // border: InputBorder.none
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Color(0xFFEAEFF5)),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Color(0xFFEAEFF5)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Color(0xFFEAEFF5)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Color(0xFFEAEFF5)),
                    ),
                  ),
                ),
                child: DropdownButtonFormField<T>(
                  value: selectedValue,
                  icon:
                      showIcon
                          ? const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          )
                          : const SizedBox.shrink(),
                  iconSize: showIcon ? 24 : 0,
                  items:
                      options.map((option) {
                        return DropdownMenuItem<T>(
                          value: option,
                          child: Text(
                            option.toString(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                        );
                      }).toList(),
                  onChanged: enabled ? onChanged : null,
                  decoration: InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    labelText: labelText,
                    hintText: hint,
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF8B96A5),
                    ),
                  ),
                ),
                // child: TextField(
                //   controller: controller,
                //   focusNode: focusNode,
                //   cursorHeight: 20.h,
                //   keyboardType: keyboardType,
                //   autofocus: autofocus,
                //   obscureText: obscureText,
                //   enabled: enabled,
                //   cursorColor: AppColor.darkGrey,
                //   style: TextStyle(
                //     fontSize: 16.sp,
                //     fontWeight: FontWeight.w400,
                //     color: AppColor.black,
                //   ),
                //   decoration: InputDecoration(
                //     floatingLabelAlignment: FloatingLabelAlignment.start,
                //     labelText: labelText,
                //     hintText: hint,
                //     hintStyle: TextStyle(
                //       fontSize: 16.sp,
                //       fontWeight: FontWeight.w400,
                //       color: const Color(0xFF8B96A5),
                //     ),
                //   ),
                //   inputFormatters: inputFormatters,
                // ),
              ),
            ),
            if (errorText != null) ...[
              AppText.sp12(errorText).w400.setColor(AppColor.red),
            ],
          ],
        );
      },
    );
  }

  static Widget whiteBorder({
    String? hint,
    String? labelText,
    FocusNode? focusNode,
    TextEditingController? controller,
    bool autofocus = false,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? prefix,
    Widget? suffixIcon,
    String? Function()? validator,
  }) {
    return FormField(
      validator: validator != null ? (v) => validator() : null,
      builder: (state) {
        String? errorText = state.errorText;
        final Color borderColor =
            errorText != null ? AppColor.red : const Color(0xFFEAEFF5);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 56.h,
              padding: EdgeInsets.symmetric(vertical: 11.h),
              decoration: BoxDecoration(border: Border.all(color: borderColor)),
              child: Theme(
                data: ThemeData(
                  inputDecorationTheme: InputDecorationTheme(
                    constraints: BoxConstraints(maxHeight: 33.h),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    labelStyle: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF8B96A5),
                    ),

                    // border: InputBorder.none
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: AppColor.white),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: AppColor.white),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: AppColor.white),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: AppColor.white),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: AppColor.white),
                    ),
                  ),
                ),
                child: TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  cursorHeight: 20.h,
                  keyboardType: keyboardType,
                  autofocus: autofocus,
                  obscureText: obscureText,
                  cursorColor: AppColor.darkGrey,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black,
                  ),
                  decoration: InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    labelText: labelText,
                    hintText: hint,
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF8B96A5),
                    ),
                  ),
                ),
              ),
            ),
            if (errorText != null) ...[
              AppText.sp12(errorText).w400.setColor(AppColor.red),
            ],
          ],
        );
      },
    );
  }
}
