import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/home/presentation/widgets/doctor_search_button.dart';
import 'package:drugs_ng/features/home/presentation/widgets/set_doctor_availability_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            12.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: Row(
                children: [
                  Expanded(
                    child: AppText.sp20(
                      DateFormat('MMMM,yyyy').format(DateTime.now()),
                    ).w400.setColor(const Color(0xFF404040)),
                  ),
                  const SetDoctorAvailabilityButton(),
                ],
              ),
            ),
            16.verticalSpace,
            // ListView.separated(itemBuilder: (context, idx){},separatorBuilder: (context, idx){},itemCount: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: Row(
                children: [
                  Container(
                    height: 63.h,
                    width: 54.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColor.primary),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText.sp14(
                          'MO',
                        ).w400.setColor(const Color(0xFF666E7D)),
                        AppText.sp14(
                          '14',
                        ).w600.setColor(const Color(0xFF666E7D)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            16.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: const DoctorSearchButton(),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 10.r),
                itemBuilder: (context, idx) {
                  return SizedBox(
                    height: 85.h,
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Container(
                          height: 85.h,
                          width: 42.w,
                          padding: EdgeInsets.only(top: 2.r),
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: const Color(0xFFDCDFE3)),
                          ),
                          child: AppText.sp12(
                            '$idx:00',
                          ).w400.setColor(const Color(0xFF212B36)),
                        ),
                        10.horizontalSpace,
                        Expanded(
                          child: Container(
                            height: 85.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.r,
                              vertical: 5.r,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.32),
                              border: const Border(
                                left: BorderSide(
                                  color: Color(0xFF12BDB2),
                                  width: 4.32,
                                ),
                              ),
                              color: const Color(0xFFF3F4F6),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText.sp12(
                                  'Robert Fox',
                                ).w400.setColor(const Color(0xFF212B36)),
                                AppText.sp10(
                                  'Consultation Started',
                                ).w400.setColor(const Color(0xFF666E7D)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, idx) => 8.verticalSpace,
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
