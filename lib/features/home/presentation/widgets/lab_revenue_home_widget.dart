import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabRevenueHomeWidget extends StatelessWidget {
  const LabRevenueHomeWidget({super.key});

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
                    AppText.sp16('Lab Revenue').w600.textColor,
                    AppText.sp14('Here is your lab revenue').w500.subText,
                  ],
                ),
              ),
              8.horizontalSpace,
              arrowBtn(false),
              5.horizontalSpace,
              arrowBtn(true),
            ],
          ),
        ),
        10.verticalSpace,
        SizedBox(
          height: 246.h,
          width: double.maxFinite,
          child: PageView(children: const [_LabSummary(), _ManageLabs()]),
        ),
      ],
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

class _ManageLabs extends StatelessWidget {
  const _ManageLabs();

  @override
  Widget build(BuildContext context) {
    final list = [
      (AppColor.primary, 'Complete blood count (CBC)', 94000, 3),
      (const Color(0xFF31B5ED), 'Urine M|C|S', 40000, 2),
      (const Color(0xFF5685A6), 'Liver Function Tests', 10600, 4),
    ];
    return Padding(
      padding: EdgeInsets.fromLTRB(20.r, 10.r, 20.r, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: const [
                    TextSpan(text: 'N240,883.'),
                    TextSpan(
                      text: '05',
                      style: TextStyle(color: AppColor.subText),
                    ),
                  ],
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              10.horizontalSpace,
              arrowTop(),
            ],
          ),
          6.verticalSpace,
          Row(
            children:
                list
                    .map(
                      (lst) => Expanded(
                        flex: lst.$4,
                        child: Container(
                          margin: EdgeInsets.only(right: 5.h),
                          height: 5.h,
                          color: lst.$1,
                        ),
                      ),
                    )
                    .toList(),
          ),
          10.verticalSpace,
          ...list.map(
            (lst) => Container(
              height: 34.h,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 20.r),
              margin: EdgeInsets.symmetric(vertical: 5.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColor.black.withOpacity(0.05)),
              ),
              child: Row(
                children: [
                  CircleAvatar(radius: 3.r, backgroundColor: lst.$1),
                  10.horizontalSpace,
                  Expanded(child: AppText.sp15(lst.$2).w600.subText),
                  10.horizontalSpace,
                  AppText.sp15('N${lst.$3}').w600.subText,
                ],
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              height: 49.h,
              width: double.maxFinite,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColor.primary,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText.sp15('Manage all Labs').w600.white,
                  5.horizontalSpace,
                  CustomImage(
                    AppSvg.labArrowRight,
                    width: 21.r,
                    color: AppColor.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget arrowTop() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 5.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColor.successPrimary.withOpacity(0.05),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImage(
            AppSvg.labArrowUp,
            width: 15.r,
            color: AppColor.successPrimary,
          ),
          AppText.sp11('+35%').w600.successPrimary,
        ],
      ),
    );
  }
}

class _LabSummary extends StatelessWidget {
  const _LabSummary();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [revenueTile(), revenueTile()],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [revenueTile(), revenueTile()],
          ),
        ],
      ),
    );
  }

  Container revenueTile() {
    return Container(
      width: 190.w,
      height: 114.h,
      padding: EdgeInsets.symmetric(horizontal: 17.r, vertical: 14.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: const Color(0x33F5F6FA),
        border: Border.all(color: AppColor.black.withOpacity(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.sp14('Total Labs').w500.textColor,
                AppText.sp25('2,350').w600.black,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText.sp14('+8.3%').w500.successPrimary,
                    AppText.sp14(' +51 Today').w500.subText,
                  ],
                ),
              ],
            ),
          ),
          10.horizontalSpace,
          CustomImage(
            AppSvg.labReceiptAdd,
            color: AppColor.primary,
            width: 19.r,
            height: 19.r,
          ),
        ],
      ),
    );
  }
}
