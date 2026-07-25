import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/textfield/border_text_field.dart';
import 'package:drugs_ng/features/verification/presentation/widgets/medical_license_field.dart';
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
                BorderTextField(
                  fillColor: AppColor.colorF7F8FB,
                  filled: true,
                  borderRadius: 14.r,
                  hint: 'Select specialization',
                ),
                20.verticalSpace,
                _requiredText('Years of Experience'),
                8.verticalSpace,
                BorderTextField(
                  fillColor: AppColor.colorF7F8FB,
                  filled: true,
                  borderRadius: 14.r,
                  hint: 'e.g. 8',
                ),
                20.verticalSpace,
                _requiredText('Medical License Number', true),
                8.verticalSpace,
                MedicalLicenseField(),
                20.verticalSpace,
                _requiredText('Hospital/Clinic Affiliation'),
                8.verticalSpace,
                BorderTextField(
                  fillColor: AppColor.colorF7F8FB,
                  filled: true,
                  borderRadius: 14.r,
                  hint: 'e.g. LUTH Laogos, University Teaching Hospital',
                ),
                20.verticalSpace,
              ],
            ),
          ),
          AppGradientButton.suffixIcon(
            text: 'Next',
            svg: Assets.svg.arrowRight,
            svgWidth: 12.w,
            status: ButtonStatus.disabled,
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
