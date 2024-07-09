import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/utils/app_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreListTile extends StatelessWidget {
  final String img;
  final double rating;
  final int totalRating;
  final String category;
  final String name;
  final double? prevPrice;
  final double price;
  final int? percentReduction;
  final void Function() onTap;

  const ExploreListTile({
    super.key,
    required this.img,
    required this.rating,
    required this.totalRating,
    required this.category,
    required this.name,
    this.prevPrice,
    required this.price,
    required this.onTap,
    this.percentReduction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 104.h,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 20,
              color: AppColor.black.withOpacity(0.06),
            )
          ],
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.asset(img),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  AppText.sp14(name).w500.black.setMaxLines(1),
                  const Spacer(),
                  AppText.sp10(category).w400.setColor(
                        const Color(0xFF8B96A5),
                      ),
                  const Spacer(),
                  Row(
                    children: [
                      (rating >= 1) ? filledStar() : outlinedStar(),
                      (rating >= 2) ? filledStar() : outlinedStar(),
                      (rating >= 3) ? filledStar() : outlinedStar(),
                      (rating >= 4) ? filledStar() : outlinedStar(),
                      (rating >= 5) ? filledStar() : outlinedStar(),
                      5.horizontalSpace,
                      AppText.sp10("($totalRating)").w400.setColor(
                            const Color(0xFF8B96A5),
                          ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      if (prevPrice != null) ...[
                        AppText.sp12("₦${TextFormater.amount(prevPrice!)}")
                            .w500
                            .setColor(const Color(0xFF8B96A5))
                            .strikeThrough,
                        2.horizontalSpace,
                      ],
                      AppText.sp12("₦${TextFormater.amount(price)}")
                          .w800
                          .primaryColor,
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
            8.horizontalSpace,
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Column(
                children: [
                  if (percentReduction != null)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF5252).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(29.r),
                      ),
                      child: AppText.sp10("-${percentReduction!}%")
                          .w400
                          .setColor(const Color(0xFFFF5252)),
                    ),
                  const Spacer(),
                  SvgPicture.asset(
                    AppSvg.heartOutline,
                    colorFilter: const ColorFilter.mode(
                        Color(0xFF8B96A5), BlendMode.srcIn),
                  ),
                ],
              ),
            ),
            8.horizontalSpace,
          ],
        ),
      ),
    );
  }

  Widget filledStar() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.r),
        child: SvgPicture.asset(
          AppSvg.starFilled,
          width: 13.w,
          height: 12.h,
          colorFilter: const ColorFilter.mode(
            AppColor.primary,
            BlendMode.srcIn,
          ),
        ),
      );

  Widget outlinedStar() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.r),
        child: SvgPicture.asset(
          AppSvg.starOutline,
          width: 13.w,
          height: 12.h,
          colorFilter: const ColorFilter.mode(
            AppColor.primary,
            BlendMode.srcIn,
          ),
        ),
      );
}
