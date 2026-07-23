import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorHomeNotificationWidget extends StatelessWidget {
  const DoctorHomeNotificationWidget({super.key});

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
                'Notification',
              ).w700.setColor(const Color(0xFF212B36)),
            ],
          ),
          32.verticalSpace,
          ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (context, idx) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.r),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImage(AppImage.received, width: 49.r, height: 48.r),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10.r),
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Color(0xFFE2E8F0),
                                  width: 4,
                                ),
                              ),
                            ),
                            child: AppText.sp14(
                              'some',
                            ).w500.setColor(const Color(0xFF475569)),
                          ),
                          8.verticalSpace,
                          AppText.sp12(
                            'some',
                          ).w500.setColor(const Color(0xFF475569)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, idx) => 20.verticalSpace,
            itemCount: 5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
