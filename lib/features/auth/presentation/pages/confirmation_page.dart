import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ConfirmationPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String btnText;
  final void Function() onTap;
  final List<TextSpan> children;
  final double? buttonTextSpacing;

  const ConfirmationPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.btnText,
    required this.onTap,
    this.buttonTextSpacing,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            const Spacer(flex: 2),
            SvgPicture.asset(AppSvg.confirmCheck, width: 111.w, height: 100.h),
            40.verticalSpace,
            AppText.sp30(title).black,
            13.verticalSpace,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(text: subtitle),
                  ...children.map((tSpan) => tSpan),
                ],
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: const Color(0xFF6D6D6D),
                ),
              ),
            ),
            (buttonTextSpacing ?? 60).verticalSpace,
            AppButton.primary(text: btnText, onTap: onTap),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
