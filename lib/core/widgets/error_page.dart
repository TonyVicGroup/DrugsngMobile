import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    required this.message,
    this.scrollable = true,
    this.onRetry,
  });

  final bool scrollable;
  final String? message;
  final void Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: scrollable ? null : const NeverScrollableScrollPhysics(),
      shrinkWrap: !scrollable,
      children: [
        SizedBox(height: 0.3.sh),
        Align(
          alignment: Alignment.center,
          child: CustomImage(
            Assets.svg.warnTriangle,
            height: 100.r,
            width: 100.r,
            color: AppColor.color0B8AE1,
          ),
        ),
        20.verticalSpace,
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            child: AppText.sp18(message ?? 'Some error occured').centerText,
          ),
        ),
        20.verticalSpace,
        if (onRetry != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextButton(onPressed: onRetry, child: Text('Resend')),
            // child: AppButton.primary(
            //   onTap: () => Navigator.pop(context),
            //   text: 'Go Back',
            // ),
          ),
      ],
    );
  }
}
