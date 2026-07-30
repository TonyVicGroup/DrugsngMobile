import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/navigation/app_route.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/product/domain/models/product_detail.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_formater.dart';
import 'package:drugs_ng/features/product/presentation/widgets/rating_stars_widget.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ProductInformationWidget extends StatelessWidget {
  const ProductInformationWidget({
    required this.inStock,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.amountSold,
    required this.price,
    super.key,
  });

  final bool inStock;
  final String name;
  final double rating;
  final double reviews;
  final double amountSold;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.r),
      decoration: BoxDecoration(
        color: AppColor.colorFFFFFF,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (inStock)
            Row(
              children: [
                CustomImage(
                  Assets.svg.checkmark,
                  width: 9.w,
                  color: AppColor.color39C316,
                ),
                8.horizontalSpace,
                AppText.sp12("In Stock").w400.setColor(AppColor.color39C316),
              ],
            ),
          4.verticalSpace,
          AppText.sp16(name).w700.black,
          10.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingStarsWidget(rating: rating),
              4.horizontalSpace,
              AppText.sp14(
                "(${rating.toStringAsFixed(1)})",
              ).w400.setColor(AppColor.primary),
              dot(),
              InkWell(
                onTap: () => viewReviews(context),
                child: iconText(
                  Assets.svg.reviews,
                  "${reviews.toInt()} reviews",
                ),
              ),
              2.horizontalSpace,
              dot(),
              iconText(Assets.svg.soldIcon, "${amountSold.toInt()} sold"),
            ],
          ),
          10.verticalSpace,
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Price: ",
                  style: TextStyle(
                    color: AppColor.color8B96A5,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppText.fontFamily,
                  ),
                ),

                TextSpan(
                  text: "₦${TextFormater.amount(price)}  ",
                  style: TextStyle(
                    color: AppColor.primary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppText.fontFamily,
                  ),
                ),
                TextSpan(
                  text: " *final price shown at checkout",
                  style: TextStyle(
                    color: AppColor.color8B96A5,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: AppText.fontFamily,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dot() => Container(
    width: 6.r,
    height: 6.r,
    margin: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0),
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFFBDC4CD),
    ),
  );

  Widget iconText(String svg, String text) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      SvgPicture.asset(
        svg,
        width: 16.r,
        height: 16.r,
        colorFilter: const ColorFilter.mode(
          AppColor.lightGrey,
          BlendMode.srcIn,
        ),
      ),
      6.horizontalSpace,
      AppText.sp14(text).w400.darkGrey,
    ],
  );

  void viewReviews(BuildContext context) {
    context.pushNamed(AppRoutes.productReviewPage);
  }
}
