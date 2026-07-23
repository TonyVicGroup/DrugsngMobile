import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/lab_appointment/presentation/pages/lab_appointment_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabAppointmentListTile extends StatelessWidget {
  const LabAppointmentListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const LabAppointmentDetailScreen();
            },
          ),
        );
      },
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(11.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColor.black.withOpacity(0.1)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            5.verticalSpace,
            Row(
              children: [
                CustomImage(
                  AppImage.testAvatar,
                  fit: BoxFit.cover,
                  width: 57.r,
                  height: 57.r,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                10.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.sp17('Some name').w600.textColor,
                      AppText.sp17('Some name').w600.subText,
                    ],
                  ),
                ),
                10.horizontalSpace,
                CustomImage(AppSvg.labArrowRight, width: 24.r),
              ],
            ),
            20.verticalSpace,
            iconRow(AppSvg.labAppointment, 'Complete blood count (CBC)'),
            11.verticalSpace,
            iconRow(AppSvg.labCalendar, '24 October 2024'),
            11.verticalSpace,
            iconRow(AppSvg.labTimer, 'Ongoing'),
            20.verticalSpace,
            Container(
              width: double.maxFinite,
              height: 48.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6FA),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColor.black.withOpacity(0.1)),
              ),
              child: AppText.sp15('Finish lab test').w600.subText,
            ),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget iconRow(String svg, String text) {
    return Row(
      children: [
        CustomImage(svg, width: 22.r, height: 22.r),
        10.horizontalSpace,
        Expanded(child: AppText.sp15(text).w500.subText),
      ],
    );
  }
}
