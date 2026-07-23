import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashCardOptionsWidget extends StatelessWidget {
  const SplashCardOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 115.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColor.colorFFFFFF,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: AppColor.shadow,
      ),
      child: Row(
        spacing: 13.w,
        children: [
          optionIcon(
            svg: Assets.svg.getConsultations,
            text: "Get Consultations",
            bgColor: AppColor.colorEAF2FD,
            iconColor: AppColor.color0B8AE1,
          ),
          optionIcon(
            svg: Assets.svg.shoppingCart,
            text: "Healthcare Products",
            bgColor: AppColor.colorE6F9F9,
            iconColor: AppColor.color02C0BB,
          ),
          optionIcon(
            svg: Assets.svg.buyMedicine,
            text: "Buy Medicine",
            bgColor: AppColor.colorEDF6FE,
            iconColor: AppColor.color0B8AE1,
          ),
          optionIcon(
            svg: Assets.svg.labTestThin,
            text: "Lab Tests",
            bgColor: AppColor.colorF4F4FD,
            iconColor: AppColor.color823AFC,
          ),
          optionIcon(
            svg: Assets.svg.moreGrid,
            text: "More",
            bgColor: AppColor.colorFEF6EF,
            iconColor: AppColor.colorFF8118,
          ),
        ],
      ),
    );
  }

  Widget optionIcon({
    required String svg,
    required String text,
    required Color bgColor,
    required Color iconColor,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            width: 38.r,
            height: 38.r,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: CustomImage(
              svg,
              width: 20.w,
              height: 20.h,
              color: iconColor,
            ),
          ),
          const Spacer(),
          AppText.sp10(text).w400.setColor(AppColor.color333333).centerText,
          const Spacer(),
        ],
      ),
    );
  }
}
