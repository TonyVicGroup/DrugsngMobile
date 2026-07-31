import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FixedLabelTextfield extends StatelessWidget {
  const FixedLabelTextfield({
    super.key,
    this.hint,
    this.labelText,
    this.focusNode,
    this.controller,
    this.keyboardType,
    this.prefix,
    this.suffixIcon,
    this.validator,
    this.onTap,
    this.enabled,
    this.inputFormatters,
    this.autofocus = false,
    this.obscureText = false,
    this.borderRadius,
  });

  final String? hint;
  final String? labelText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool autofocus;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefix;
  final Widget? suffixIcon;
  final String? Function()? validator;
  final bool? enabled;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: validator != null ? (v) => validator?.call() : null,
      builder: (state) {
        String? errorText = state.errorText;
        final Color borderColor =
            errorText != null ? AppColor.red : const Color(0xFFEAEFF5);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: onTap,
              child: Container(
                height: 56.h,
                padding: EdgeInsets.symmetric(vertical: 11.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAEFF5),
                  border: Border.all(color: borderColor),
                  borderRadius: borderRadius ?? BorderRadius.circular(15.r),
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
                    readOnly: onTap != null ? true : false,
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
}
