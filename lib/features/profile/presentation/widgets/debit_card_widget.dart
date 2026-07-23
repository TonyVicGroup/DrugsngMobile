import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/profile/data/models/debit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DebitCardWidget extends StatelessWidget {
  const DebitCardWidget({super.key, required this.card});

  final DebitCard card;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 314.w,
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: AppColor.primary,
        image: const DecorationImage(
          image: AssetImage(AppImage.cardOrnament),
          alignment: Alignment.bottomCenter,
          fit: BoxFit.fitWidth,
          opacity: 0.1,
        ),
      ),
      child: Column(
        children: [
          22.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  AppSvg.delete,
                  width: 20.r,
                  height: 20.r,
                  colorFilter: const ColorFilter.mode(
                    AppColor.white,
                    BlendMode.srcIn,
                  ),
                ),
                AppText.sp12("Debit").w500.white,
              ],
            ),
          ),
          const Spacer(flex: 4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Row(
              children: [
                Expanded(
                  child:
                      AppText.sp20(
                        "**** **** **** ${card.cardNumber.substring(card.cardNumber.length - 4)}",
                      ).w700.white,
                ),
                12.horizontalSpace,
                AppText.sp6("VALID\nTHRU").w400.white,
                12.horizontalSpace,
                AppText.sp12(
                  DateFormat('MM/yy').format(card.expiryDate),
                ).w500.white,
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Row(
              children: [
                Expanded(child: AppText.sp20(card.nameOnCard).w700.white),
                12.horizontalSpace,
                Image.asset(AppImage.mastercard, height: 25.r),
              ],
            ),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
