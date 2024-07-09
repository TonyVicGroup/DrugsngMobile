import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 5,
        surfaceTintColor: AppColor.white,
        backgroundColor: AppColor.white,
        leading: Center(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              width: 20.r,
              height: 20.r,
              child: SvgPicture.asset(AppSvg.chevronThick),
            ),
          ),
        ),
        title: AppText.sp18("Notifications").w700.black,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 14.h),
        itemBuilder: (context, index) {
          return NotificationListTile();
        },
        itemCount: 20,
      ),
    );
  }
}

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.r),
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 14.r,
                          height: 14.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(width: 4.r, color: AppColor.primary),
                          ),
                        ),
                        6.horizontalSpace,
                        AppText.sp12("Appointment").w400.primaryColor,
                        Padding(
                          padding: EdgeInsets.all(6.r),
                          child: Container(
                            width: 3.r,
                            height: 3.r,
                            decoration: const BoxDecoration(
                              color: AppColor.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        AppText.sp12("now").w400.black,
                        6.horizontalSpace,
                        RotatedBox(
                          quarterTurns: 3,
                          child: SvgPicture.asset(
                            AppSvg.chevronThick,
                            height: 7.r,
                            colorFilter: const ColorFilter.mode(
                                AppColor.black, BlendMode.srcIn),
                          ),
                        ),
                      ],
                    ),
                    9.verticalSpace,
                    AppText.sp16("Upcoming Doctor Appointment").w500.black,
                    4.verticalSpace,
                    AppText.sp14(
                            "Reminder: You have an appointment with Dr. Jane Smith")
                        .w400
                        .setColor(const Color(0xFF8B96A5)),
                  ],
                ),
              ),
              Image.asset(
                AppImage.molfix,
                width: 36.w,
                height: 36.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
