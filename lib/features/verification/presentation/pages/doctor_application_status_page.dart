import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_outline_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorApplicationStatusPage extends StatelessWidget {
  const DoctorApplicationStatusPage({super.key});

  static Route<dynamic> route(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => DoctorApplicationStatusPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorFFFFFF,
      body: Center(
        child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColor.colorF5F7FA,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              40.verticalSpace,
              Container(
                width: 100.r,
                height: 100.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.colorFF9800.withAlpha(25),
                ),
                child: CustomImage(
                  Assets.svg.timerCircle,
                  width: 50.r,
                  height: 50.r,
                  color: AppColor.colorFF9800,
                ),
              ),
              11.verticalSpace,
              AppText.sp22(
                "Application Under Review",
              ).w700.setColor(AppColor.color333333),
              11.verticalSpace,
              AppText.sp14(
                "Your application is being reviewed by our admin team. "
                "This process typically takes up to 72 hours.",
              ).w400.setColor(AppColor.color666666).centerText,
              11.verticalSpace,
              Container(
                width: double.maxFinite,
                height: 219.h,
                padding: EdgeInsets.fromLTRB(16.w, 28.5.h, 16.w, 24.6.h),
                decoration: BoxDecoration(
                  color: AppColor.colorFFFFFF,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.sp13(
                      'WHAT HAPPENS NEXT?',
                    ).w400.setColor(AppColor.color999999),
                    10.verticalSpace,
                    _buildRequirementItem(1, 'Personal & Professional Info'),
                    const Spacer(),
                    _buildRequirementItem(2, 'Medical Credentials'),
                    const Spacer(),
                    _buildRequirementItem(3, 'ID Verification'),
                    const Spacer(),
                    _buildRequirementItem(4, 'Bank Account Details'),
                    const Spacer(),
                    _buildRequirementItem(5, 'Admin Approval'),
                  ],
                ),
              ),
              11.verticalSpace,
              AppOutlineButton(
                text: 'Back to Patient Mode',
                onTap: () => _backToPatientMode(context),
              ),
              40.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementItem(int index, String item) {
    return Row(
      children: [
        Container(
          width: 16.67.r,
          height: 16.67.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColor.colorE0E0E0, width: 2.r),
          ),
          child: CustomImage(
            Assets.svg.checkmark,
            color: AppColor.colorE0E0E0,
            width: 10.r,
          ),
        ),
        10.horizontalSpace,
        AppText.sp14(item).w400.setColor(AppColor.color999999),
      ],
    );
  }

  void _backToPatientMode(BuildContext context) {}
}
