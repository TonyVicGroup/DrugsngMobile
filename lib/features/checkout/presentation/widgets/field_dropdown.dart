import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FieldDropdown extends StatelessWidget {
  final Key? _key;

  final String label;
  final String? value;
  final List<String?> options;
  final void Function(String value) onChanged;
  final String? Function()? validator;
  final void Function()? onTap;
  final double? height;
  final Color? backgroundColor;

  // ignore: use_key_in_widget_constructors
  const FieldDropdown({
    Key? key,
    required this.label,
    required this.options,
    required this.onChanged,
    this.validator,
    this.onTap,
    this.height,
    this.value,
    this.backgroundColor,
  }) : _key = key;

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: validator != null ? (v) => validator!() : null,
      builder: (state) {
        String? errorText = state.errorText;
        final Color borderColor =
            errorText != null
                ? AppColor.red
                : (backgroundColor ?? const Color(0xFFEAEFF5));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 56.h,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: 11.h),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                color: backgroundColor,
              ),
              child: Theme(
                data: ThemeData(
                  inputDecorationTheme: InputDecorationTheme(
                    constraints: BoxConstraints(maxHeight: 33.h),
                    contentPadding: EdgeInsets.only(left: 20.w),
                    labelStyle: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF8B96A5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(
                        color: backgroundColor ?? AppColor.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(
                        color: backgroundColor ?? AppColor.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(
                        color: backgroundColor ?? AppColor.white,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(
                        color: backgroundColor ?? AppColor.white,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(
                        color: backgroundColor ?? AppColor.white,
                      ),
                    ),
                  ),
                ),
                child: DropdownButtonFormField(
                  key: _key,
                  value: value,
                  onTap: onTap,
                  decoration: InputDecoration(
                    labelText: label,
                    border: InputBorder.none,
                  ),
                  dropdownColor: AppColor.white,
                  icon: Padding(
                    padding: EdgeInsets.only(right: 11.h),
                    child: SvgPicture.asset(
                      AppSvg.chevronLight,
                      width: 15.w,
                      colorFilter: const ColorFilter.mode(
                        AppColor.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  items:
                      options
                          .map(
                            (e) => DropdownMenuItem<String?>(
                              value: e,
                              child:
                                  e == null
                                      ? const CircularProgressIndicator()
                                      : AppText.sp16(e),
                            ),
                          )
                          .toList(),
                  onChanged: (item) {
                    if (item != null) onChanged(item);
                  },
                ),
              ),
            ),
            if (errorText != null)
              AppText.sp12(errorText).w400.setColor(AppColor.red),
          ],
        );
      },
    );
  }
}
