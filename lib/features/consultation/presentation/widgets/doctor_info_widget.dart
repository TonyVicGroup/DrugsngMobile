import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DoctorInfoWidget extends StatelessWidget {
  final DoctorDetails doctor;

  const DoctorInfoWidget({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: const Color(0xFFEDF8FF),
      ),
      child: Row(
        children: [
          info(AppSvg.location, "Location", doctor.location),
          info(AppSvg.globe, "Years Exp", "${doctor.yearsOfExp}+"),
          info(AppSvg.personRound, "Patients", "${doctor.patients}+"),
        ],
      ),
    );
  }

  Widget info(String svg, String title, String info) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText.sp18(info).w500.primaryColor,
          11.verticalSpace,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                svg,
                width: 14.r,
                height: 14.r,
                colorFilter: const ColorFilter.mode(
                  AppColor.primary,
                  BlendMode.srcIn,
                ),
              ),
              5.horizontalSpace,
              AppText.sp14(title).w400.primaryColor,
            ],
          ),
        ],
      ),
    );
  }
}
