import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetDoctorAvailabilityButton extends StatelessWidget {
  const SetDoctorAvailabilityButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0x33979797)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImage(AppSvg.setting, width: 16.r, height: 16.r),
          10.horizontalSpace,
          AppText.sp16('Set Availability').w400.primaryColor,
        ],
      ),
    );
  }
}
