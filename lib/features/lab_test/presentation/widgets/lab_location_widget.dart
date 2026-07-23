import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/lab_test/domain/models/laboratory_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabLocationWidget extends StatelessWidget {
  final LaboratoryData laboratory;
  const LabLocationWidget({super.key, required this.laboratory});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: double.maxFinite,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF8FF),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.r),
              child: Image.asset(AppImage.labLocation),
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppText.sp16(laboratory.name).w600.primaryColor,
                AppText.sp14(laboratory.address).w400.black,
                AppText.sp14(laboratory.phoneNumber).w400.black,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
