import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/buttons/app_outline_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/lab_test/domain/models/lab_result_model.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabTestResultListTile extends StatelessWidget {
  const LabTestResultListTile({super.key, required this.labTestResultModel});
  final LabResultModel labTestResultModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.5.w, vertical: 19.5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        color: AppColor.colorFFFFFF,
        border: Border.all(color: AppColor.colorE8EEF4, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 48.r,
                height: 48.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColor.color0B8AE1,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText.sp14(
                      'You have no lab results yet',
                    ).w700.setColor(AppColor.color1A2332),
                    5.verticalSpace,
                    AppText.sp11(
                      "Once you book your first lab test, you'll",
                    ).w500.setColor(AppColor.color6B7280),
                  ],
                ),
              ),
              10.horizontalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColor.color0B8AE1,
                ),
              ),
            ],
          ),
          24.verticalSpace,
          Row(
            children: [
              infoItem(Assets.svg.calendarToday, 'Apr 25, 2026'),
              14.horizontalSpace,
              infoItem(Assets.svg.timerCircle, 'Apr 25, 2026'),
              14.horizontalSpace,
              infoItem(Assets.svg.videoOutline, 'Apr 25, 2026'),
            ],
          ),
          24.verticalSpace,
          Row(
            children: [
              Expanded(
                child: AppGradientButton.prefixIcon(
                  text: 'Join Call',
                  svg: Assets.svg.videoOutline,
                  onTap: () {},
                  height: 39.4.h,
                ),
              ),
              8.horizontalSpace,
              Expanded(
                child: AppOutlineButton(
                  text: 'Join Call',
                  onTap: () {},
                  height: 39.4.h,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoItem(String svg, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomImage(
          svg,
          width: 13.r,
          height: 13.r,
          color: AppColor.color0B8AE1,
        ),
        5.horizontalSpace,
        AppText.sp11(text).w600.setColor(AppColor.color6B7280),
      ],
    );
  }
}
