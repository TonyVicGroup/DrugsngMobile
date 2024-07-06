import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/checkout/presentation/pages/cart_page.dart';
import 'package:drugs_ng/src/features/home/domain/product.dart';
import 'package:drugs_ng/src/features/home/presentation/widgets/product_card_widget.dart';
import 'package:drugs_ng/src/features/product/presentation/pages/product_review_page.dart';
import 'package:drugs_ng/src/features/product/presentation/widgets/product_detail_carousel.dart';
import 'package:drugs_ng/src/features/product/presentation/widgets/product_information_widget.dart';
import 'package:drugs_ng/src/features/product/presentation/widgets/product_specification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 5,
        surfaceTintColor: AppColor.white,
        backgroundColor: AppColor.white,
        leading: Center(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              width: 20.r,
              height: 20.r,
              child: SvgPicture.asset(AppSvg.chevronThick),
            ),
          ),
        ),
        title: AppText.sp18("Product Details").w700.black,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ProductDetailCarousel(
            images: const [
              AppImage.syrup,
              AppImage.vitamin,
              AppImage.molfix,
            ],
            onLike: () {},
          ),
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppSvg.checkMark,
                      width: 9.w,
                      colorFilter: const ColorFilter.mode(
                        AppColor.green,
                        BlendMode.srcIn,
                      ),
                    ),
                    8.horizontalSpace,
                    AppText.sp12("In Stock").w400.setColor(AppColor.green),
                  ],
                ),
                2.verticalSpace,
                AppText.sp16(
                        "Genexa Kid's Allergy (Diphenhydramine HCI) Antihistamine")
                    .w700
                    .black,
                20.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (product.rating >= 1) ? filledStar() : unselectedStar(),
                    (product.rating >= 2) ? filledStar() : unselectedStar(),
                    (product.rating >= 3) ? filledStar() : unselectedStar(),
                    (product.rating >= 4) ? filledStar() : unselectedStar(),
                    (product.rating >= 5) ? filledStar() : unselectedStar(),
                    5.horizontalSpace,
                    AppText.sp14(product.rating.toString())
                        .w400
                        .setColor(AppColor.primary),
                    dot(),
                    InkWell(
                        onTap: () => viewReviews(context),
                        child: iconText(
                            AppSvg.reviews, "${product.ratingCount} reviews")),
                    2.horizontalSpace,
                    dot(),
                    iconText(AppSvg.sold, "158 sold"),
                  ],
                ),
                10.verticalSpace,
                const ProductSpecificationWidget(),
                20.verticalSpace,
                const ProductInformationWidget(),
                43.verticalSpace,
                AppText.sp12("1 item added to cart").w400.black,
                5.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: AppButton.primary(
                        text: "ADD TO CART",
                        onTap: () => addToCart(context),
                      ),
                    ),
                    21.horizontalSpace,
                    const _CheckoutIcon(),
                  ],
                ),
                40.verticalSpace,
                AppText.sp16("Similar Product").w500.black,
                22.verticalSpace,
                SizedBox(
                  height: 263.h,
                  width: double.maxFinite,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemBuilder: (context, index) {
                        return ProductCardWidget(
                          image: product.image,
                          name: "name",
                          category: "category",
                          price: 1233,
                          rating: 3,
                          totalRating: 32,
                        );
                      },
                      separatorBuilder: (context, index) => 15.horizontalSpace,
                      itemCount: 5),
                ),
                50.verticalSpace,
              ],
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
          width: 16.w,
          height: 15.h,
          colorFilter: const ColorFilter.mode(
            AppColor.primary,
            BlendMode.srcIn,
          ),
        ),
      );

  Widget unselectedStar() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.r),
        child: SvgPicture.asset(
          AppSvg.starFilled,
          width: 16.w,
          height: 15.h,
          colorFilter: const ColorFilter.mode(
            Color(0xFFBDC4CD),
            BlendMode.srcIn,
          ),
        ),
      );

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
    Navigator.of(context).push(
      AppUtils.transition(const ProductReviewPage()),
    );
  }

  void addToCart(BuildContext context) {}
}

class _CheckoutIcon extends StatelessWidget {
  const _CheckoutIcon();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goToCart(context),
      child: SizedBox(
        width: 40.r,
        height: 40.r,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 7.w,
                  vertical: 7.h,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFBDC4CD),
                  ),
                ),
                child: SvgPicture.asset(
                  AppSvg.shopping,
                  colorFilter: const ColorFilter.mode(
                    AppColor.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primary,
                ),
                child: AppText.sp10("1").w500.white.setLineHeight(1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goToCart(BuildContext context) {
    Navigator.of(context).push(
      AppUtils.transition(const CartPage()),
    );
  }
}
