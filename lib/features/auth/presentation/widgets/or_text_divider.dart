import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrTextDivider extends StatelessWidget {
  const OrTextDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1.h, color: AppColor.colorE0E0E0)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 9.w),
          child: AppText.sp17('or').w400.setColor(AppColor.color333333),
        ),
        Expanded(child: Divider(thickness: 1.h, color: AppColor.colorE0E0E0)),
      ],
    );
  }
}
