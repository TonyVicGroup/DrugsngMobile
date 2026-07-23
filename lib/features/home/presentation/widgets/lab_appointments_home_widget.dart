import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/lab_appointment_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabAppointmentsHomeWidget extends StatelessWidget {
  const LabAppointmentsHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.sp16('Appointments').w600.textColor,
                    AppText.sp14(
                      'Here are you today\'s appointments',
                    ).w500.subText,
                  ],
                ),
              ),
              SizedBox(
                width: 45.r,
                height: 45.r,
                child: Center(
                  child: CustomImage(
                    AppSvg.labSort,
                    width: 22.9.r,
                    height: 22.9.r,
                  ),
                ),
              ),
              6.horizontalSpace,
              arrowBtn(false),
              6.horizontalSpace,
              arrowBtn(true),
            ],
          ),
        ),
        20.verticalSpace,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [appointmentTile(), appointmentTile()]),
        ),
      ],
    );
  }

  Widget appointmentTile() {
    return Container(
      width: 349.w,
      margin: EdgeInsets.only(left: 16.r),
      child: const LabAppointmentListTile(),
    );
  }

  InkWell arrowBtn(bool isNext) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 43.r,
        width: 43.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColor.black.withOpacity(0.1)),
        ),
        child: RotatedBox(
          quarterTurns: isNext ? 2 : 0,
          child: CustomImage(AppSvg.labShortArrow, width: 16.r),
        ),
      ),
    );
  }
}
