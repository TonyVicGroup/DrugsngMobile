import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final Function()? clickPolicy;
  const PrivacyPolicyWidget({
    super.key,
    required this.value,
    required this.onChanged,
    this.clickPolicy,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: const Color(0xFF31B5ED).withOpacity(0.05),
        ),
        child: Row(
          children: [
            Container(
              width: 16.r,
              height: 16.r,
              padding: EdgeInsets.all(1.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                color: value ? AppColor.primary : null,
                border: Border.all(
                    color: value ? AppColor.primary : AppColor.darkGrey,
                    width: 1.0),
              ),
              child: SvgPicture.asset(
                AppSvg.checkMark,
                width: 16.r,
                height: 16.r,
              ),
            ),
            10.horizontalSpace,
            RichText(
              text: TextSpan(
                text: "I accept the ",
                children: [
                  TextSpan(
                    text: "Terms and Privacy Policy",
                    style: TextStyle(
                      color: AppColor.primary,
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
