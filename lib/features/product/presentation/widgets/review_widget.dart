import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/product/data/models/product_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ReviewWidget extends StatelessWidget {
  final ProductReview review;
  const ReviewWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,

      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFEAEFF5)),
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: AppColor.primary.withAlpha(50),
                child: AppText.sp25(review.reviewer.avatar).w700.primaryColor,
              ),

              _stars(review.rating),
            ],
          ),
          10.verticalSpace,
          AppText.sp16(review.reviewer.fullName).w800.black,
          10.verticalSpace,
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 90.h),
            child: AppText.sp14(review.reviewComment).w400.black,
          ),
          // AppText.sp12(
          //   "11 people found this helpful",
          // ).w400.setColor(const Color(0xFFBDC4CD)),
          // Row(
          //   children: [
          //     _likeDislikeBtn(AppSvg.like, "Helpful", () {}),
          //     10.horizontalSpace,
          //     _likeDislikeBtn(AppSvg.dislike, "Unhelpful", () {}),
          //     const Spacer(),
          //     InkWell(
          //       child: SvgPicture.asset(
          //         AppSvg.flag,
          //         height: 16.r,
          //         colorFilter: const ColorFilter.mode(
          //           AppColor.red,
          //           BlendMode.srcIn,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _stars(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        rating >= 1 ? _starFilled() : _starOutline(),
        rating >= 2 ? _starFilled() : _starOutline(),
        rating >= 3 ? _starFilled() : _starOutline(),
        rating >= 4 ? _starFilled() : _starOutline(),
        rating >= 5 ? _starFilled() : _starOutline(),
      ],
    );
  }

  InkWell _likeDislikeBtn(String svg, String text, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: 82.w,
        height: 32.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFFE5E5E5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              svg,
              height: 16.r,
              colorFilter: const ColorFilter.mode(
                Color(0xFFBDC4CD),
                BlendMode.srcIn,
              ),
            ),
            3.horizontalSpace,
            AppText.sp12(text).w400.setColor(const Color(0xFFBDC4CD)),
          ],
        ),
      ),
    );
  }

  SvgPicture _starOutline() {
    return SvgPicture.asset(
      AppSvg.starOutline,
      height: 16.r,
      colorFilter: const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
    );
  }

  SvgPicture _starFilled() {
    return SvgPicture.asset(
      AppSvg.starFilled,
      height: 16.r,
      colorFilter: const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
    );
  }
}
