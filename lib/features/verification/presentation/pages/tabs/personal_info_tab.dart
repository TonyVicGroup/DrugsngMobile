import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/textfield/border_text_field.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInfoTab extends StatelessWidget {
  const PersonalInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                20.verticalSpace,
                AppText.sp24(
                  'Personal Information',
                ).w700.setColor(AppColor.color1A1D26),
                3.verticalSpace,
                AppText.sp13(
                  'Fill in your professional details to get started.',
                ).w400.setColor(AppColor.color7C8098),
                20.verticalSpace,
                _requiredText('Specialization', true),
                8.verticalSpace,
                BorderTextField(fillColor: AppColor.colorF7F8FB, filled: true),
                20.verticalSpace,
                _requiredText('Years of Experience'),
                8.verticalSpace,
                BorderTextField(fillColor: AppColor.colorF7F8FB, filled: true),
                20.verticalSpace,
                _requiredText('Medical License Number', true),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: BorderTextField(
                        fillColor: AppColor.colorF7F8FB,
                        filled: true,
                      ),
                    ),
                    12.horizontalSpace,
                    Container(
                      width: 100.w,
                      height: 52.r,
                      decoration: BoxDecoration(
                        color: AppColor.color0B8AE1,
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: AppColor.shadow,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImage(
                            Assets.svg.halfShield,
                            width: 13.r,
                            height: 13.r,
                            color: AppColor.colorFFFFFF,
                          ),
                          2.horizontalSpace,
                          AppText.sp14(
                            'Verify',
                          ).w700.setColor(AppColor.colorFFFFFF),
                        ],
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,
                _requiredText('Hospital/Clinic Affiliation'),
                8.verticalSpace,
                BorderTextField(fillColor: AppColor.colorF7F8FB, filled: true),
                20.verticalSpace,
              ],
            ),
          ),
          AppGradientButton.suffixIcon(
            text: 'Next',
            svg: Assets.svg.arrowRight,
            svgWidth: 12.w,
            onTap: () {},
          ),
          SizedBox(height: context.appPadding.bottom),
        ],
      ),
    );
  }

  Widget _requiredText(String text, [bool required = false]) {
    return Row(
      children: [
        AppText.sp13(text).w600.setColor(AppColor.color1A1D26),
        if (required) AppText.sp14(' *').w600.setColor(AppColor.colorDC2626),
      ],
    );
  }
}
