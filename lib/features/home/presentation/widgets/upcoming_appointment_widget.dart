import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpcomingAppointmentWidget extends StatelessWidget {
  const UpcomingAppointmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 10.r),
      margin: EdgeInsets.symmetric(horizontal: 16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0x33979797)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              AppText.sp20(
                'Upcoming Appointments',
              ).w700.setColor(const Color(0xFF212B36)),
            ],
          ),
          32.verticalSpace,
          Container(
            width: double.maxFinite,
            height: 48.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: const Color(0xFFF1F4F9),
            ),
            child: Row(
              children: [
                _titleText('Patient Name'),
                _titleText('Date-Time'),
                _titleText('Disease/Infection'),
                _titleText('Amount'),
              ],
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 5.r),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFF979797))),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CustomImage(
                            AppImage.testDoctorProfile,
                            width: 24.r,
                            height: 24.r,
                          ),
                          Expanded(
                            child: AppText.sp12(
                              'Sanusi Igardo',
                            ).w400.setColor(const Color(0xFF212B36)),
                          ),
                        ],
                      ),
                    ),
                    _infoText('23902/232'),
                    _infoText('N 3000'),
                    _infoText('Heart Problem'),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => 20.verticalSpace,
            itemCount: 3,
          ),
          // 20.verticalSpace,
        ],
      ),
    );
  }

  Expanded _titleText(String text) => Expanded(
    child: AppText.sp12(text).w700.setColor(const Color(0xFF212B36)),
  );
  Expanded _infoText(String text) => Expanded(
    child: AppText.sp12(text).w400.setColor(const Color(0xFF212B36)),
  );
}
