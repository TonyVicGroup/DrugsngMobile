import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/utils/app_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCardWidget extends StatelessWidget {
  final String image;
  final String category;
  final String name;
  final int rating;
  final int totalRating;
  final double price;
  final double? prevPrice;
  final int? percentReduction;
  final void Function()? onTap;
  final void Function()? onLike;

  const ProductCardWidget({
    super.key,
    required this.image,
    required this.name,
    required this.category,
    this.prevPrice,
    required this.price,
    required this.rating,
    required this.totalRating,
    this.onTap,
    this.onLike,
    this.percentReduction,
  }) : assert(rating <= 5 && price > 0);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 148.w,
        height: 263.h,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 184.h,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: AppColor.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 20,
                    )
                  ],
                ),
                child: Image.asset(
                  image,
                  height: 100.r,
                  width: 100.r,
                ),
              ),
            ),
            Positioned(
              top: 164.h,
              right: 0,
              child: InkWell(
                onTap: onLike,
                child: Container(
                  width: 36.w,
                  height: 36.h,
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFEDF8FF),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: SvgPicture.asset(
                    AppSvg.heartOutline,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF8B96A5),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 189.h,
              right: 0,
              left: 0,
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  AppText.sp10(category).w400.setColor(
                        const Color(0xFF8B96A5),
                      ),
                  const Spacer(),
                  AppText.sp14(name).w500.black.setMaxLines(1),
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
            if (percentReduction != null)
              Positioned(
                top: 8.h,
                left: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5252).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(29.r),
                  ),
                  child: AppText.sp10("-${percentReduction!}%")
                      .w400
                      .setColor(const Color(0xFFFF5252)),
                ),
              ),
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
