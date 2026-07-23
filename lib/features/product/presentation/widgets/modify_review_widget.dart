import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/product/presentation/pages/edit_review_page.dart';
import 'package:drugs_ng/features/profile/data/models/review.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/reviews_cubit.dart';
// import 'package:drugs_ng/src/features/product/domain/models/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ModifyReviewWidget extends StatelessWidget {
  final Review review;
  const ModifyReviewWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      // height: 300.h,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFEAEFF5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: AppColor.primary.withAlpha(50),
                child: AppText.sp25(review.avatar).w700.primaryColor,
              ),
              _stars(review.ratingStar.toInt()),
            ],
          ),
          10.verticalSpace,
          AppText.sp16(review.userName).w800.black,
          10.verticalSpace,
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 90.h),
            child: AppText.sp14(review.reviewComment).w400.black,
          ),
          20.verticalSpace,
          // AppText.sp12(
          //   "11 people found this helpful",
          // ).w400.setColor(const Color(0xFFBDC4CD)),
          Row(
            children: [
              _editBtn("Edit Review", () {
                Navigator.push(
                  context,
                  AppUtils.transition(EditReviewPage(review: review)),
                );
              }),
              const Spacer(),
              InkWell(
                onTap: () {
                  context.read<ReviewsCubit>().deleteReview(
                    reviewId: review.id,
                  );
                },
                child: SvgPicture.asset(
                  AppSvg.delete,
                  height: 16.r,
                  colorFilter: const ColorFilter.mode(
                    AppColor.red,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
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

  InkWell _editBtn(String text, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        // width: 97.w,
        // height: 32.h,
        padding: EdgeInsets.all(8.r),
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
              AppSvg.edit,
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
