import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/item_type_enum.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/wishlist_button.dart';
import 'package:drugs_ng/core/utils/app_formater.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCardWidget extends StatelessWidget {
  final String? image;
  final String? genericName;
  final String name;
  final int itemId;
  final int rating;
  final int? totalRating;
  final double price;
  final ItemTypeEnum itemType;
  // final double? prevPrice;
  // final int? percentReduction;
  final void Function()? onTap;
  // final Future<void> Function()? onLike;

  const ProductCardWidget({
    super.key,
    this.image,
    required this.itemId,
    required this.name,
    this.genericName,
    // this.prevPrice,
    required this.price,
    this.rating = 0,
    this.totalRating,
    this.onTap,
    required this.itemType,
    // this.onLike,
    // this.percentReduction,
  }) : assert(rating <= 5 && price >= 0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 148.w,
      height: 263.h,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 184.h,
            child: InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: AppColor.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: SizedBox.square(
                    dimension: 100.r,
                    child: Builder(
                      builder: (context) {
                        // if (image == null) return const SizedBox();
                        return CustomImage(image ?? '', fit: BoxFit.cover);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 164.h,
            right: 0,
            child: BlocBuilder<WishlistCubit, WishlistState>(
              builder: (context, state) {
                return WishlistButton(produtId: itemId, itemType: itemType);
              },
            ),
          ),
          Positioned(
            top: 189.h,
            right: 0,
            left: 0,
            bottom: 0,
            child: InkWell(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ...List.generate(5, (i) {
                        return rating > i ? filledStar() : outlinedStar();
                      }),
                      5.horizontalSpace,
                      if (totalRating != null)
                        AppText.sp10(
                          "($totalRating)",
                        ).w400.setColor(const Color(0xFF8B96A5)),
                    ],
                  ),
                  const Spacer(),
                  if (genericName != null)
                    AppText.sp10(
                      genericName!,
                    ).w400.setColor(const Color(0xFF8B96A5)),
                  const Spacer(),
                  AppText.sp14(name).w500.black.setMaxLines(1),
                  const Spacer(),
                  Row(
                    children: [
                      // if (prevPrice != null) ...[
                      //   AppText.sp12("₦${TextFormater.amount(prevPrice!)}")
                      //       .w500
                      //       .setColor(const Color(0xFF8B96A5))
                      //       .strikeThrough,
                      //   2.horizontalSpace,
                      // ],
                      AppText.sp12(
                        "₦${TextFormater.amount(price)}",
                      ).w800.primaryColor,
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          // if (percentReduction != null)
          //   Positioned(
          //     top: 8.h,
          //     left: 8.w,
          //     child: Container(
          //       padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.r),
          //       decoration: BoxDecoration(
          //         color: const Color(0xFFFF5252).withOpacity(0.1),
          //         borderRadius: BorderRadius.circular(29.r),
          //       ),
          //       child: AppText.sp10("-${percentReduction!}%")
          //           .w400
          //           .setColor(const Color(0xFFFF5252)),
          //     ),
          //   ),
        ],
      ),
    );
  }

  Widget filledStar() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.r),
    child: SvgPicture.asset(
      AppSvg.starFilled,
      width: 13.w,
      height: 12.h,
      colorFilter: const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
    ),
  );

  Widget outlinedStar() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.r),
    child: SvgPicture.asset(
      AppSvg.starOutline,
      width: 13.w,
      height: 12.h,
      colorFilter: const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
    ),
  );
}
