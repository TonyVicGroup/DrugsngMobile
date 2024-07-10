import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ConfirmationPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String btnText;
  final void Function() onTap;
  const ConfirmationPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.btnText,
    required this.onTap,
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
            SvgPicture.asset(
              AppSvg.confirmCheck,
              width: 111.w,
              height: 100.h,
            ),
            40.verticalSpace,
            AppText.sp30(title).black,
            13.verticalSpace,
            AppText.sp16(subtitle).darkGrey.centerText,
            60.verticalSpace,
            AppButton.primary(text: btnText, onTap: onTap),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
