import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/enum/item_type_enum.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/features/checkout/data/models/cart.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/cart_cubit.dart';
import 'package:drugs_ng/features/product/domain/models/product_detail.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/cart_page.dart';
import 'package:drugs_ng/features/home/presentation/widgets/product_card_widget.dart';
import 'package:drugs_ng/features/product/presentation/cubit/product_detail_cubit.dart';
import 'package:drugs_ng/features/product/presentation/pages/product_reviews_page.dart';
import 'package:drugs_ng/features/product/presentation/widgets/product_detail_carousel.dart';
import 'package:drugs_ng/features/product/presentation/widgets/product_detail_loader.dart';
import 'package:drugs_ng/features/product/presentation/widgets/product_information_widget.dart';
import 'package:drugs_ng/features/product/presentation/widgets/product_specification_widget.dart';
import 'package:drugs_ng/features/product/presentation/widgets/rating_stars_widget.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();

  static Route<dynamic> route(RouteSettings settings) {
    final productId = settings.arguments as int;
    return MaterialPageRoute(
      builder: (ctx) => ProductDetailPage(productId: productId),
    );
  }
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  ValueNotifier<ButtonStatus> status = ValueNotifier<ButtonStatus>(
    ButtonStatus.active,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductDetailCubit>().getData(widget.productId);
    });
  }

  @override
  void dispose() {
    status.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 5,
        surfaceTintColor: AppColor.white,
        backgroundColor: AppColor.white,

        title: AppText.sp18("Product Details").w700.black,
        centerTitle: true,
      ),
      body: BlocBuilder<ProductDetailCubit, ProductState>(
        builder: (context, state) {
          if (state.productStatus.isLoadingOrInitial) {
            return const ProductDetailLoader();
          } else if (state.productStatus.isFailed) {
            final String message;
            if (state.productStatus.isFailed) {
              message = state.error ?? "An unknown error occurred";
            } else {
              message = "An unknown error occurred";
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                AppText.sp16(message).w500,
                10.verticalSpace,
                const Row(),
                InkWell(
                  onTap: () {
                    context.read<ProductDetailCubit>().getData(
                      widget.productId,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText.sp16("Retry").w800.primaryColor,
                        5.horizontalSpace,
                        Icon(
                          Icons.refresh,
                          color: AppColor.primary,
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 3),
              ],
            );
          } else {
            ProductDetail product = state.product!;
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                10.verticalSpace,
                ProductDetailCarousel(
                  images: product.imageUrls,
                  produtId: product.id,
                  itemType: ItemTypeEnum.product,
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomImage(
                            Assets.svg.checkmark,
                            width: 9.w,
                            color: AppColor.green,
                          ),
                          8.horizontalSpace,
                          AppText.sp12(
                            "In Stock",
                          ).w400.setColor(AppColor.green),
                        ],
                      ),
                      4.verticalSpace,
                      AppText.sp16(product.name).w700.black,
                      20.verticalSpace,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RatingStarsWidget(
                            rating: product.averageRating.toDouble(),
                          ),
                          4.horizontalSpace,
                          AppText.sp14(
                            "(${product.averageRating.toStringAsFixed(1)})",
                          ).w400.setColor(AppColor.primary),
                          dot(),
                          InkWell(
                            onTap: () => viewReviews(context),
                            child: iconText(
                              AppSvg.reviews,
                              "${product.reviews.length} reviews",
                            ),
                          ),
                          2.horizontalSpace,
                          dot(),
                          iconText(AppSvg.sold, "${product.amountSold} sold"),
                        ],
                      ),
                      10.verticalSpace,
                      ProductSpecificationWidget(product: product),
                      20.verticalSpace,
                      ProductInformationWidget(product: product),
                      43.verticalSpace,
                      BlocConsumer<CartCubit, CartState>(
                        listener: (context, state) {
                          if (state is CartStateError) {
                            AppToast.warn(
                              context,
                              title: 'Error',
                              msg: state.error.message,
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is CartStateInitial) {
                            context.read<CartCubit>().getCart();
                          }
                          int idx = state.cart.items.indexWhere((ct) {
                            return ct.name == product.name &&
                                ct.itemId == product.id;
                          });
                          if (idx >= 0) {
                            return AppText.sp12(
                              "${state.cart.items[idx].quantity} item added to cart",
                            ).w400.black;
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                      5.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: ValueListenableBuilder(
                              valueListenable: status,
                              builder: (context, value, child) {
                                return AppButton.primary(
                                  text: "ADD TO CART",
                                  onTap: () async {
                                    await addToCart(context, product);
                                  },
                                  status: value,
                                );
                              },
                            ),
                          ),
                          21.horizontalSpace,
                          const _CheckoutIcon(),
                        ],
                      ),
                      if (state.similarProduct.isNotEmpty) ...[
                        40.verticalSpace,
                        AppText.sp16("Similar Products").w500.black,
                        22.verticalSpace,
                        SizedBox(
                          height: 263.h,
                          width: double.maxFinite,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            itemCount: state.similarProduct.length,
                            itemBuilder: (context, index) {
                              final product = state.similarProduct[index];
                              return ProductCardWidget(
                                image: product.imageUrls.firstOrNull,
                                name: product.name,
                                itemId: product.id,
                                genericName: product.genericName,
                                price: product.price,
                                rating: product.rating,
                                itemType: ItemTypeEnum.product,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    AppUtils.transition(
                                      ProductDetailPage(productId: product.id),
                                    ),
                                  );
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return 16.horizontalSpace;
                            },
                          ),
                        ),
                      ],
                      50.verticalSpace,
                    ],
                  ),
                ),
              ],
            );
          }
        },
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
    Navigator.of(context).push(
      AppUtils.transition(ProductReviewsPage(productId: widget.productId)),
    );
  }

  Future addToCart(BuildContext context, ProductDetail product) async {
    status.value = ButtonStatus.loading;
    final items = context.read<CartCubit>().state.cart.items;
    bool exists =
        items.indexWhere((ct) {
          return ct.name == product.name && ct.itemId == product.id;
        }) >=
        0;

    if (exists) {
      await context.read<CartCubit>().increase(
        product.name,
        widget.productId,
        1,
      );
    } else {
      await context.read<CartCubit>().addItem(
        CartItem(
          itemId: widget.productId,
          name: product.name,
          size: product.size,
          form: product.productFormName,
          quantity: 1,
          amount: product.price,
          url: null,
          type: null,
        ),
      );
    }
    status.value = ButtonStatus.active;
  }
}

class _CheckoutIcon extends StatelessWidget {
  const _CheckoutIcon();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goToCart(context),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return SizedBox(
            width: 40.sp,
            height: 40.sp,
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
                      border: Border.all(color: const Color(0xFFBDC4CD)),
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
                if (state.totalItems() > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.primary,
                      ),
                      child: AppText.sp10(
                        "${state.totalItems()}",
                      ).w500.white.setLineHeight(1),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void goToCart(BuildContext context) {
    Navigator.of(context).push(AppUtils.transition(const CartPage()));
  }
}
