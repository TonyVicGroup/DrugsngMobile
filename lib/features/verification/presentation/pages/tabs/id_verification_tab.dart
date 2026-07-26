import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IdVerificationTab extends StatelessWidget {
  const IdVerificationTab({super.key, required this.controller});
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      children: [
        20.verticalSpace,
        AppText.sp24('ID Verification').w700.setColor(AppColor.color1A1D26),
        3.verticalSpace,
        AppText.sp13(
          'Upload a valid government-issued ID and provide your'
          ' ID number for verification.',
        ).w400.setColor(AppColor.color7C8098),
        20.verticalSpace,
        Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: AppColor.colorFFFFFF,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColor.colorF0F1F3, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.sp13(
                'MEANS OF IDENTIFICATION',
              ).w700.setColor(AppColor.color6B7280),
            ],
          ),
        ),
        20.verticalSpace,
      ],
    );
  }
}
