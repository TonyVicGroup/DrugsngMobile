import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessfulLicenceVerificationWidget extends StatelessWidget {
  const SuccessfulLicenceVerificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 242.h,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColor.colorECFDF5,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.color16A34A.withAlpha(50)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.color16A34A.withAlpha(35),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: CustomImage(
                  Assets.svg.halfShield,
                  width: 18.r,
                  height: 18.r,
                  color: AppColor.color16A34A,
                ),
              ),
              10.horizontalSpace,
              AppText.sp15(
                'License Verified Successfully',
              ).w700.setColor(AppColor.color16A34A),
            ],
          ),
          10.verticalSpace,
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColor.colorFFFFFF,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColor.color16A34A.withAlpha(30)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40.r,
                        height: 40.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: AppColor.lightBlueGradient,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: AppText.sp16(
                          'SN',
                        ).w800.setColor(AppColor.color0B8AE1),
                      ),
                      10.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.sp15(
                            'Dr. Sample Name',
                          ).w700.setColor(AppColor.color1A1D26),
                          AppText.sp12(
                            'MDCN-2024-00182',
                          ).w400.setColor(AppColor.color7C8098),
                        ],
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  _infRow(label: 'Specialization', value: 'Cardiology'),
                  const Spacer(),
                  _infRow(label: 'Issued Date', value: 'Jan 15, 2026'),
                  const Spacer(),
                  _infRow(label: 'Expiry Date', value: 'Dec 31, 2026'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infRow({required String label, required String value}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          SizedBox(
            width: 90.w,
            child: AppText.sp11(label).w500.setColor(AppColor.color7C8098),
          ),
          Expanded(
            flex: 3,
            child: AppText.sp13(
              value,
            ).w600.setColor(AppColor.color1A1D26).setLineHeight(1),
          ),
        ],
      ),
    );
  }
}
