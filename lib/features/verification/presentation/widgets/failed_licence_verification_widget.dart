import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FailedLicenceVerificationWidget extends StatelessWidget {
  const FailedLicenceVerificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 260.h,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColor.colorFEF2F2,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.color16A34A.withAlpha(50)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          10.verticalSpace,
          Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.colorDC2626.withAlpha(35),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: CustomImage(
                  Assets.svg.warnTriangle,
                  width: 18.r,
                  height: 18.r,
                  color: AppColor.colorDC2626,
                ),
              ),
              10.horizontalSpace,
              AppText.sp15(
                'Verification Failed',
              ).w700.setColor(AppColor.colorDC2626),
            ],
          ),
          10.verticalSpace,
          AppText.sp12(
            'We could not verify this license number. Please check the following issues:',
          ).w400.setColor(AppColor.color7F1D1D),
          10.verticalSpace,
          _info(
            text1: 'License number ',
            text2: 'MDCN-2019-77401',
            text3:
                ' was not found in the Medical and Dental Council of Nigeria registry.',
          ),
          const Spacer(),
          _info(
            text1:
                'The license format appears valid, but the record may'
                ' have been revoked or suspended since last update.',
            text2: '',
            text3: '',
          ),
          const Spacer(),
          _info(
            text1:
                'Please ensure there are no typos. If the issue'
                ' persists, contact MDCN at ',
            text2: 'support@mdcn.gov.ng.',
            text3: '',
          ),
          20.verticalSpace,
        ],
      ),
    );
  }

  Widget _info({
    required String text1,
    required String text2,
    required String text3,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 2.r),
          width: 12.r,
          height: 12.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColor.colorDC2626,
            shape: BoxShape.circle,
          ),
          child: CustomImage(
            Assets.svg.close,
            width: 7.r,
            height: 7.r,
            color: AppColor.colorFFFFFF,
          ),
        ),
        9.horizontalSpace,
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: text1),
                TextSpan(
                  text: text2,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: text3),
              ],
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.color5F2121,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
