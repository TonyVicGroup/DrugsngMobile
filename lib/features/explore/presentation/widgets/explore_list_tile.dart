import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/item_type_enum.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/wishlist_button.dart';
import 'package:drugs_ng/core/utils/app_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreListTile extends StatelessWidget {
  final String? img;
  final int rating;
  final int? totalRating;
  final String genericName;
  final String name;
  final double? prevPrice;
  final double price;
  final int? percentReduction;
  final void Function() onTap;
  // final void Function() addWishlist;
  final int itemId;
  final ItemTypeEnum itemType;

  const ExploreListTile({
    super.key,
    required this.img,
    this.rating = 0,
    this.totalRating,
    required this.genericName,
    required this.name,
    this.prevPrice,
    required this.price,
    required this.onTap,
    this.percentReduction,
    // required this.addWishlist,
    required this.itemId,
    required this.itemType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104.h,
      width: double.maxFinite,
      child: Stack(
        children: [
          Positioned.fill(
            child: InkWell(
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
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: CustomImage(
                        img ?? '',
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(8.r),
                        ),
                      ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          AppText.sp14(name).w500.black.setMaxLines(1),
                          const Spacer(),
                          AppText.sp10(genericName).w400
                              .setColor(const Color(0xFF8B96A5))
                              .setMaxLines(1),
                          const Spacer(),
                          Row(
                            children: [
                              ...List.generate(5, (i) {
                                return rating > i
                                    ? filledStar()
                                    : outlinedStar();
                              }),
                              5.horizontalSpace,
                              if (totalRating != null)
                                AppText.sp10(
                                  "($totalRating)",
                                ).w400.setColor(const Color(0xFF8B96A5)),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              if ((prevPrice ?? 0) > 0) ...[
                                AppText.sp12(
                                      "₦${TextFormater.amount(prevPrice!)}",
                                    ).w500
                                    .setColor(const Color(0xFF8B96A5))
                                    .strikeThrough,
                                2.horizontalSpace,
                              ],
                              AppText.sp12(
                                "₦${TextFormater.amount(price)}",
                              ).w800.primaryColor,
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
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 4.r,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF5252).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(29.r),
                              ),
                              child: AppText.sp10(
                                "-${percentReduction!}%",
                              ).w400.setColor(const Color(0xFFFF5252)),
                            ),
                          const Spacer(),
                          // InkWell(
                          //   onTap: addWishlist,
                          //   child: SvgPicture.asset(
                          //     AppSvg.heartOutline,
                          //     colorFilter: const ColorFilter.mode(
                          //       Color(0xFF8B96A5),
                          //       BlendMode.srcIn,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    8.horizontalSpace,
                  ],
                ),
              ),
            ),
          ),
          // positioned wishlist button
          Positioned(
            bottom: 2.h,
            right: 8.w,
            child: WishlistButton(
              produtId: itemId,
              itemType: itemType,
              bgColor: Colors.transparent,
            ),
          ),
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
