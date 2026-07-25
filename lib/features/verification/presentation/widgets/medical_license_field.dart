import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/textfield/border_text_field.dart';
import 'package:drugs_ng/features/verification/presentation/cubit/doctor_registration_cubit.dart';
import 'package:drugs_ng/features/verification/presentation/widgets/failed_licence_verification_widget.dart';
import 'package:drugs_ng/features/verification/presentation/widgets/successful_licence_verification_widget.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicalLicenseField extends StatelessWidget {
  const MedicalLicenseField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorRegistrationCubit, DoctorRegistrationState>(
      builder: (context, state) {
        // final status = state.verifyLicenseStatus;
        final status = LoadStatusEnum.success;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: BorderTextField(
                    readOnly: status.isSuccess,
                    fillColor: _fillColor(status),
                    filled: true,
                    borderRadius: 14.r,
                    borderColor: _borderColor(status),
                    hint: 'E.G. MDCN-2024-00182',
                    suffixIcon: suffixIcon(status),
                  ),
                ),
                12.horizontalSpace,
                Container(
                  width: 100.w,
                  height: 52.r,
                  decoration: BoxDecoration(
                    color: _buttonColor(status),
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: AppColor.shadow,
                  ),
                  child:
                      status.isLoading
                          ? Center(
                            child: SizedBox(
                              height: 20.r,
                              width: 20.r,
                              child: CircularProgressIndicator(
                                color: AppColor.colorFFFFFF,
                              ),
                            ),
                          )
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomImage(
                                _svg(status),
                                width: 13.r,
                                height: 13.r,
                                color: AppColor.colorFFFFFF,
                              ),
                              2.horizontalSpace,
                              AppText.sp14(
                                _text(status),
                              ).w700.setColor(AppColor.colorFFFFFF),
                            ],
                          ),
                ),
              ],
            ),
            _infoWidget(status),
          ],
        );
      },
    );
  }

  Color _buttonColor(LoadStatusEnum status) {
    switch (status) {
      case LoadStatusEnum.loading:
        return AppColor.color0B8AE1;
      case LoadStatusEnum.initial:
        return AppColor.color0B8AE1;
      case LoadStatusEnum.success:
        return AppColor.color16A34A;
      case LoadStatusEnum.failed:
        return AppColor.colorDC2626;
    }
  }

  String _svg(LoadStatusEnum status) {
    switch (status) {
      case LoadStatusEnum.loading:
        return Assets.svg.halfShield;
      case LoadStatusEnum.initial:
        return Assets.svg.halfShield;
      case LoadStatusEnum.success:
        return Assets.svg.checkCircle;
      case LoadStatusEnum.failed:
        return Assets.svg.retry;
    }
  }

  String _text(LoadStatusEnum status) {
    switch (status) {
      case LoadStatusEnum.loading:
        return '';
      case LoadStatusEnum.initial:
        return 'Verify';
      case LoadStatusEnum.success:
        return 'Verified';
      case LoadStatusEnum.failed:
        return 'Retry';
    }
  }

  Color _borderColor(LoadStatusEnum status) {
    switch (status) {
      case LoadStatusEnum.loading:
        return AppColor.colorBDC4CD;
      case LoadStatusEnum.initial:
        return AppColor.colorBDC4CD;
      case LoadStatusEnum.success:
        return AppColor.color16A34A;
      case LoadStatusEnum.failed:
        return AppColor.colorDC2626;
    }
  }

  Color? _fillColor(LoadStatusEnum status) {
    switch (status) {
      case LoadStatusEnum.loading:
        return AppColor.colorF7F8FB;
      case LoadStatusEnum.initial:
        return AppColor.colorF7F8FB;
      case LoadStatusEnum.success:
        return AppColor.colorF0FDF4;
      case LoadStatusEnum.failed:
        return AppColor.colorFEF2F2;
    }
  }

  Widget? suffixIcon(LoadStatusEnum status) {
    if (status.isFailed) {
      return Container(
        width: 24.r,
        height: 24.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.r),
          color: AppColor.colorDC2626,
        ),
        child: CustomImage(
          Assets.svg.close,
          width: 11.r,
          height: 11.r,
          color: AppColor.colorFFFFFF,
        ),
      );
    } else if (status.isSuccess) {
      return Container(
        width: 24.r,
        height: 24.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.r),
          color: AppColor.color16A34A,
        ),
        child: CustomImage(
          Assets.svg.checkmark,
          width: 12.r,
          height: 12.r,
          color: AppColor.colorFFFFFF,
        ),
      );
    } else {
      return null;
    }
  }

  Widget _infoWidget(LoadStatusEnum status) {
    return Builder(
      builder: (context) {
        if (status.isFailed) {
          return Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: FailedLicenceVerificationWidget(),
          );
        } else if (status.isSuccess) {
          return Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: SuccessfulLicenceVerificationWidget(),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
