import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FixedLabelDropdownField<T> extends StatelessWidget {
  const FixedLabelDropdownField({
    super.key,
    this.hint,
    this.labelText,
    this.selectedValue,
    required this.options,
    this.validator,
    this.onChanged,
    this.inputFormatters,
    this.enabled = true,
    this.showIcon = false,
    this.borderRadius,
  });

  final String? hint;
  final String? labelText;
  final T? selectedValue;
  final List<T> options;
  final String? Function()? validator;
  final bool enabled;
  final void Function(T?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool showIcon;
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
            Container(
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
}
