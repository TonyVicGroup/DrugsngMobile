import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorReloadWidget extends StatelessWidget {
  const ErrorReloadWidget({super.key, required this.message, this.onReload});
  final String message;
  final void Function()? onReload;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 100.r,
          width: 100.r,
          child: const CustomImage(AppImage.errorIcon),
        ),
        20.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: AppText.sp18(message).centerText,
        ),
        10.verticalSpace,
        if (onReload != null)
          InkWell(
            onTap: onReload,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.refresh),
                10.horizontalSpace,
                AppText.sp16('Reload'),
              ],
            ),
          ),
        5.verticalSpace,
      ],
    );
  }
}
