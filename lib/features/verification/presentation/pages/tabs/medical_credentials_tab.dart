import 'package:dotted_border/dotted_border.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/verification/presentation/widgets/info_card_widget.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicalCredentialsTab extends StatelessWidget {
  const MedicalCredentialsTab({super.key, required this.controller});
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.verticalSpace,
          InfoCardWidget(
            title: 'Verification Required',
            subtitle: 'Your credentials will be verified within 72 hours',
          ),
          16.verticalSpace,
          AppText.sp15(
            'Upload Medical License *',
          ).w700.setColor(AppColor.color333333),
          4.verticalSpace,
          AppText.sp13(
            'Ensure all details are clearly visible',
          ).w400.setColor(AppColor.color666666),
          10.verticalSpace,
          DottedBorder(
            radius: Radius.circular(16.r),
            dashPattern: [6, 4],
            borderType: BorderType.RRect,
            strokeWidth: 2,
            color: AppColor.colorE0E0E0,

            child: SizedBox(
              width: double.maxFinite,
              height: 199.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60.r,
                    height: 60.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.color0B8AE1.withAlpha(25),
                    ),
                    child: CustomImage(
                      Assets.svg.upload,
                      width: 24.r,
                      height: 24.r,
                      color: AppColor.color0B8AE1,
                    ),
                  ),
                  8.verticalSpace,
                  AppText.sp14(
                    'Upload Medical License',
                  ).w600.setColor(AppColor.color666666).centerText,
                  8.verticalSpace,
                  AppText.sp12(
                    'PDF, JPG, PNG • Max 5MB',
                  ).w400.setColor(AppColor.color999999).centerText,
                  8.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
