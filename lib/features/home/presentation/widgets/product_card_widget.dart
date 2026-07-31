import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/enum/item_type_enum.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/extensions/widget_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/widgets/wishlist_button.dart';
import 'package:drugs_ng/core/utils/app_formater.dart';
import 'package:drugs_ng/features/checkout/data/models/cart.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/cart_cubit.dart';
import 'package:drugs_ng/features/lab_test/domain/models/diagnostic_test.dart';
import 'package:drugs_ng/features/lab_test/domain/models/wellness_package.dart';
import 'package:drugs_ng/features/product/domain/models/product.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
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
  final double? prevPrice;
  final void Function() onTap;
  final double? width;
  final double? height;

  factory ProductCardWidget.fromProductModel({
    required void Function() onTap,
    required Product product,
    double? width,
    double? height,
  }) {
    return ProductCardWidget(
      itemId: product.id,
      name: product.name,
      genericName: product.genericName,
      price: product.price,
      onTap: onTap,
      itemType: ItemTypeEnum.product,
      width: width,
      height: height,
      image: product.imageUrls.firstOrNull,
      rating: product.rating,
      totalRating: product.rating,
    );
  }

  factory ProductCardWidget.fromLabTest({
    required void Function() onTap,
    required DiagnosticTest labTest,
    double? width,
    double? height,
  }) {
    return ProductCardWidget(
      itemId: labTest.id,
      name: labTest.name,
      price: labTest.price,
      onTap: onTap,
      itemType: ItemTypeEnum.test,
      width: width,
      height: height,
      image: labTest.imageUrls,
      rating: 0,
      totalRating: 0,
    );
  }

  factory ProductCardWidget.fromConsultation({
    required void Function() onTap,
    required WellnessPackage wellnessPackage,
    double? width,
    double? height,
  }) {
    return ProductCardWidget(
      itemId: wellnessPackage.id,
      name: wellnessPackage.name,
      price: wellnessPackage.price,
      onTap: onTap,
      itemType: ItemTypeEnum.test,
      width: width,
      height: height,
      image: wellnessPackage.imageUrl,
      rating: 0,
      totalRating: 0,
    );
  }

  const ProductCardWidget({
    super.key,
    this.image,
    required this.itemId,
    required this.name,
    this.genericName,
    this.prevPrice,
    required this.price,
    this.rating = 0,
    this.totalRating,
    required this.onTap,
    required this.itemType,
    this.width,
    this.height,
  }) : assert(rating <= 5 && price >= 0);

  @override
  Widget build(BuildContext context) {
    return AppButtonAnimator(
      onTap: onTap,
      child: Container(
        width: width ?? 152.w,
        height: height ?? 294.h,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.r),
          color: AppColor.colorFFFFFF,
          boxShadow: [
            BoxShadow(
              color: AppColor.colorBDC4CD.withAlpha(25),
              blurRadius: 10.r,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (prevPrice != null) ...[
              Container(
                width: 43.w,
                height: 19.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(29.r),
                  ),
                  color: AppColor.colorF87868,
                ),
              ),
            ] else
              SizedBox(height: 19.h),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: ClipRRect(
                child: CustomImage(
                  image ?? '',
                  width: 137.w,
                  height: 119.h,
                  borderRadius: BorderRadiusGeometry.vertical(
                    top: Radius.circular(17.r),
                  ),
                ),
              ),
            ),
            const Spacer(),
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
            AppText.sp12(name).w500
                .setColor(AppColor.color333333)
                .setMaxLines(2)
                .padSymmetric(horizontal: 6.w),
            const Spacer(),
            AppText.sp10(genericName ?? '').w500
                .setColor(AppColor.color8B96A5)
                .setMaxLines(2)
                .padSymmetric(horizontal: 6.w),
            const Spacer(flex: 2),
            RichText(
              text: TextSpan(
                children: [
                  // TextSpan(
                  //   text: "₦${TextFormater.amount(price)}  ",
                  //   style: TextStyle(
                  //     color: AppColor.color8B96A5,
                  //     fontSize: 10.sp,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  TextSpan(
                    text: "₦${TextFormater.amount(price)}",
                    style: TextStyle(
                      color: AppColor.color333333,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ).padSymmetric(horizontal: 6.w),
            const Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<CartCubit, CartState>(
                  buildWhen:
                      (prev, curr) =>
                          context.isOnScreen ||
                          prev.updateProductStatus != curr.updateProductStatus,
                  builder: (context, state) {
                    final isLoading =
                        state.updateProductStatus.isLoading &&
                        state.updatedProdId == itemId.toString();
                    return ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 114.w),
                      child: AppGradientButton.prefixIcon(
                        text: 'Add to cart',
                        svg: Assets.svg.shoppingCart,
                        height: 35.h,
                        fontSize: 11.sp,
                        svgWidth: 17.w,
                        width: 95.w,
                        spacer: 3.w,
                        status:
                            isLoading
                                ? ButtonStatus.loading
                                : ButtonStatus.active,
                        onTap: () => addToCart(context),
                      ),
                    );
                  },
                ),
                WishlistButton(produtId: itemId, itemType: itemType),
              ],
            ).padSymmetric(horizontal: 4.w),
          ],
        ),
      ),
    );
  }

  Widget filledStar() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.r),
    child: SvgPicture.asset(
      Assets.svg.starFilled,
      width: 13.w,
      height: 12.h,
      colorFilter: const ColorFilter.mode(
        AppColor.color0B8AE1,
        BlendMode.srcIn,
      ),
    ),
  );

  Widget outlinedStar() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.r),
    child: SvgPicture.asset(
      Assets.svg.starOutline,
      width: 13.w,
      height: 12.h,
      colorFilter: const ColorFilter.mode(
        AppColor.colorBDC4CD,
        BlendMode.srcIn,
      ),
    ),
  );

  Future<void> addToCart(BuildContext context) async {
    final result = await context.read<CartCubit>().addItem(
      CartItem(
        itemId: itemId,
        name: name,
        size: '',
        form: '',
        quantity: 1,
        amount: price,
        url: image,
        type: null,
      ),
    );
    if (context.mounted && result) {
      AppToast.success(
        context,
        title: 'Added to Cart',
        msg: '$name has been added to cart',
      );
    }
  }
}
