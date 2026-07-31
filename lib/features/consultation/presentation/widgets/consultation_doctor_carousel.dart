import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsultationDoctorCarousel extends StatelessWidget {
  const ConsultationDoctorCarousel({super.key, this.padding});
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 216.h,
      child: ListView(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        children: [
          _ActiveConsultationHeaderWidget(),
          5.horizontalSpace,
          _ConsultationHeaderWidget(),
        ],
      ),
    );
  }
}

class _ActiveConsultationHeaderWidget extends StatelessWidget {
  const _ActiveConsultationHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButtonAnimator(
      onTap: () {},
      child: Container(
        width: 334.w,
        padding: EdgeInsets.all(18.r),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColor.color0B8AE1, AppColor.color084EA7],
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.color68DEFF,
                  ),
                ),
                8.horizontalSpace,
                Expanded(
                  child: AppText.sp11(
                    'Active Healthcare'.toUpperCase(),
                  ).w600.setColor(AppColor.colorB8D9D2),
                ),
                5.horizontalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColor.colorFFFFFF.withAlpha(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomImage(
                        Assets.svg.timerCircle,
                        width: 11.r,
                        height: 11.r,
                        color: AppColor.colorFFFFFF,
                      ),
                      5.horizontalSpace,
                      AppText.sp11(
                        'In 2h 14m',
                      ).w600.setColor(AppColor.colorF4F1EA),
                    ],
                  ),
                ),
              ],
            ),
            14.verticalSpace,
            Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColor.colorFFFFFF,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: CustomImage(
                    Assets.svg.doctorUser,
                    width: 18.w,
                    color: AppColor.color0B8AE1,
                  ),
                ),
                15.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.sp15(
                        'Dr. Chinyere Okonkwo',
                      ).w700.setColor(AppColor.colorFFFFFF).setMaxLines(2),
                      AppText.sp12(
                        'General Physician · Meet consult',
                      ).w400.setColor(AppColor.colorFFFFFF).setMaxLines(2),
                    ],
                  ),
                ),
                10.horizontalSpace,
                Container(
                  width: 71.w,
                  height: 33.h,
                  decoration: BoxDecoration(
                    color: AppColor.colorFFFFFF,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImage(
                        Assets.svg.videoCall,
                        width: 14.w,
                        color: AppColor.color0B8AE1,
                      ),
                      3.horizontalSpace,
                      AppText.sp12('Join').w600.setColor(AppColor.color0B8AE1),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: 48.6.h,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColor.colorFFFFFF.withAlpha(30)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _rowItem(
                    title: 'Date',
                    info: 'Today',
                    svg: Assets.svg.calendarToday,
                  ),
                  Divider(color: AppColor.colorFFFFFF.withAlpha(20)),
                  _rowItem(
                    title: 'Time',
                    info: '03:00PM',
                    svg: Assets.svg.timerCircle,
                  ),
                  Divider(color: AppColor.colorFFFFFF.withAlpha(20)),
                  _rowItem(
                    title: 'Type',
                    info: 'Meet',
                    svg: Assets.svg.videoCall,
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _rowItem({
    required String title,
    required String info,
    required String svg,
  }) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 2.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppText.sp10(
              title.toUpperCase(),
            ).w600.setColor(AppColor.colorB8D9D2),
            3.verticalSpace,
            Row(
              children: [
                CustomImage(svg, width: 12.r, color: AppColor.color68DEFF),
                5.horizontalSpace,
                AppText.sp12(info).w600.setColor(AppColor.colorFFFFFF),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ConsultationHeaderWidget extends StatelessWidget {
  const _ConsultationHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButtonAnimator(
      onTap: () {},
      child: Container(
        width: 389.w,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.color0E2769, AppColor.color32C9E6],
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: -10.w,
              top: 14.h,
              child: CustomImage(
                Assets.images.sampleDoctor.path,
                height: 192.h,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              top: 0,
              left: 17.w,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 2),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: AppColor.colorFFFFFF,
                    ),
                    child: AppText.sp14(
                      "12 Doctors Available",
                    ).w500.setColor(AppColor.color0E2769).setLineHeight(1),
                  ),
                  const Spacer(),
                  AppText.sp25("Get Expert Advice.").w600.white,
                  5.verticalSpace,
                  AppText.sp14("Schedule a Consultation Today.").w400.white,
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      gradient: LinearGradient(
                        colors: [AppColor.color0D5CC2, AppColor.color00D6EF],
                      ),
                    ),
                    child: AppText.sp14(
                      "Book Now",
                    ).w600.setColor(AppColor.colorFFFFFF),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
