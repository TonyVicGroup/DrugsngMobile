import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/features/verification/presentation/widgets/info_card_widget.dart';
import 'package:drugs_ng/features/verification/presentation/widgets/upload_file_button.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicalCredentialsTab extends StatelessWidget {
  const MedicalCredentialsTab({super.key, required this.controller});
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
        UploadFileButton(
          svg: Assets.svg.upload,
          title: 'Upload Medical License',
          subtitle: 'PDF, JPG, PNG • Max 5MB',
          onTap: () {},
        ),
        20.verticalSpace,
        AppText.sp15(
          'Upload Medical Degree/Certificate',
        ).w700.setColor(AppColor.color333333),
        4.verticalSpace,
        AppText.sp13(
          'MBBS, MD, or equivalent',
        ).w400.setColor(AppColor.color666666),
        10.verticalSpace,
        UploadFileButton(
          svg: Assets.svg.document,
          title: 'Upload Certificate',
          subtitle: 'PDF, JPG, PNG • Max 5MB',
          onTap: () {},
        ),
        30.verticalSpace,
        AppGradientButton(text: 'Next', onTap: () {}),
        30.verticalSpace,
      ],
    );
  }
}
