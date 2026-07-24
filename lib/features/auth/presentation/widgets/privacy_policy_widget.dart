import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  final bool value;
  final bool hasError;
  final Function(bool) onChanged;
  final Function()? clickPolicy;

  const PrivacyPolicyWidget({
    super.key,
    required this.value,
    required this.onChanged,
    this.clickPolicy,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: AppColor.color31B5ED.withOpacity(0.05),
          border: hasError ? Border.all(color: AppColor.red) : null,
        ),
        child: Row(
          children: [
            Container(
              width: 16.r,
              height: 16.r,
              padding: EdgeInsets.all(1.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: value ? AppColor.color31B5ED : null,
                border: Border.all(
                  color: value ? AppColor.color31B5ED : AppColor.color6D6D6D,
                  width: 1.0,
                ),
              ),
              child:
                  value
                      ? CustomImage(
                        Assets.svg.checkmark,
                        width: 16.r,
                        height: 16.r,
                        color: AppColor.colorFFFFFF,
                      )
                      : null,
            ),
            10.horizontalSpace,
            RichText(
              text: TextSpan(
                text: "I accept the ",
                children: [
                  TextSpan(
                    text: "Terms and Privacy Policy",
                    style: TextStyle(
                      color: AppColor.color0B8AE1,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = clickPolicy,
                  ),
                ],
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                  fontFamily: AppText.fontFamily,
                  height: 1.25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
