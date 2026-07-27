import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/core/extensions/string_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/textfield/border_text_field.dart';
import 'package:drugs_ng/features/verification/domain/entities/verify_list_tile_entity.dart';
import 'package:drugs_ng/features/verification/presentation/cubit/doctor_registration_cubit.dart';
import 'package:drugs_ng/features/verification/presentation/widgets/otp_verification_modal.dart';
import 'package:drugs_ng/features/verification/presentation/widgets/upload_file_button.dart';
import 'package:drugs_ng/features/verification/presentation/widgets/verified_failed_widget.dart';
import 'package:drugs_ng/features/verification/presentation/widgets/verified_success_widget.dart';
import 'package:drugs_ng/features/verification/presentation/widgets/warning_card_widget.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IdVerificationTab extends StatelessWidget {
  const IdVerificationTab({super.key, required this.controller});
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorRegistrationCubit, DoctorRegistrationState>(
      builder: (context, state) {
        // final status = state.idVerifyStatus;
        final status = LoadStatusEnum.success;
        if (status.isLoadingOrInitial) {
          return _IDVerifyWidget(state: state);
        } else if (status.isFailed) {
          return VerifiedFailedWidget();
        } else if (status.isSuccess) {
          return VerifiedSuccessWidget.identity(
            title: 'Identity Verified',
            subtitle:
                'Your government-issued ID has been verified'
                ' successfully. Proceed to the next step.',
            items: [
              VerifyListTileEntity.blackText(
                title: 'ID Type',
                value: 'National ID Card',
              ),
              VerifyListTileEntity.blackText(
                title: 'ID Number',
                value: 'NGN-28472093209'.hideNumber,
              ),
              VerifyListTileEntity.blueIconText(
                svg: Assets.svg.checkCircle,
                title: 'Name Match',
                value: 'Verified',
              ),
              VerifyListTileEntity.blueIconText(
                svg: Assets.svg.checkCircle,
                title: 'Phone Verified',
                value: 'Verified',
              ),
            ],
            onNext: () {},
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

class _IDVerifyWidget extends StatelessWidget {
  const _IDVerifyWidget({super.key, required this.state});

  final DoctorRegistrationState state;

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
            boxShadow: AppColor.shadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.sp13(
                'MEANS OF IDENTIFICATION',
              ).w700.setColor(AppColor.color6B7280),
              20.verticalSpace,
              _requiredText('ID Type', true),
              8.verticalSpace,
              BorderTextField(
                fillColor: AppColor.colorF7F8FB,
                filled: true,
                borderRadius: 14.r,
                hint: 'Select specialization',
              ),
              20.verticalSpace,
              _requiredText('ID Number', true),
              8.verticalSpace,
              BorderTextField(
                fillColor: AppColor.colorF7F8FB,
                filled: true,
                borderRadius: 14.r,
                hint: 'Enter your ID number',
              ),
              20.verticalSpace,
              _requiredText('Upload ID Document', true),
              8.verticalSpace,
              UploadFileButton(
                svg: Assets.svg.upload,
                title: 'Upload ID Document',
                subtitle:
                    'Front and back (if applicable\n'
                    'PDF, JPG, PNG · Max 5MB',
                onTap: () {},
              ),
              20.verticalSpace,
            ],
          ),
        ),
        20.verticalSpace,
        WarningCardWidget(
          title: 'Important: ',
          subtitle:
              'The name on your ID must match the name on your profile.'
              ' Mismatched names will cause verification failure.',
        ),
        20.verticalSpace,
        AppGradientButton.prefixIcon(
          svg: Assets.svg.send,
          text: 'Send OTP',
          onTap: () => _sendOtp(context),
        ),
        40.verticalSpace,
      ],
    );
  }

  Widget _requiredText(String text, [bool required = false]) {
    return Row(
      children: [
        AppText.sp13(text).w600.setColor(AppColor.color1A1D26),
        if (required) AppText.sp16('*').w600.setColor(AppColor.colorDC2626),
      ],
    );
  }

  Future<void> _sendOtp(BuildContext context) async {
    OtpVerificationModal.show(context);
  }
}
