import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class RatingStarsWidget extends StatelessWidget {
  final double rating;
  const RatingStarsWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        rating > 0 ? filledStar() : unselectedStar(),
        rating > 1 ? filledStar() : unselectedStar(),
        rating > 2 ? filledStar() : unselectedStar(),
        rating > 3 ? filledStar() : unselectedStar(),
        rating > 4 ? filledStar() : unselectedStar(),
        // ...List.generate(5, (i) {
        //   return rating > i ? filledStar() : unselectedStar();
        // }),
      ],
    );
  }

  Widget filledStar() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.r),
    child: SvgPicture.asset(
      AppSvg.starFilled,
      width: 16.w,
      height: 15.h,
      colorFilter: const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
    ),
  );

  Widget unselectedStar() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.r),
    child: SvgPicture.asset(
      AppSvg.starFilled,
      width: 16.w,
      height: 15.h,
      colorFilter: const ColorFilter.mode(Color(0xFFBDC4CD), BlendMode.srcIn),
    ),
  );
}
