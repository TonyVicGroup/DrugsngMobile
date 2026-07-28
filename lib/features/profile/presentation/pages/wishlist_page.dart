import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/fetch_more_indicator.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/explore_list_tile.dart';
import 'package:drugs_ng/features/product/presentation/pages/product_detail_page.dart';
import 'package:drugs_ng/features/profile/data/models/wishlist.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/wishlist_cubit.dart';
import 'package:drugs_ng/features/search/presentation/pages/search_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            shadowColor: Colors.black.withOpacity(0.2),
            elevation: 5,
            surfaceTintColor: AppColor.white,
            backgroundColor: AppColor.white,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Center(
                child: SizedBox(
                  width: 20.sp,
                  height: 20.sp,
                  child: SvgPicture.asset(AppSvg.chevronThick),
                ),
              ),
            ),
            title: AppText.sp18("Wishlist").w700.black,
            centerTitle: true,
            actions: [
              if (!state.status.isLoading)
                IconButton(
                  onPressed: () {
                    context.read<WishlistCubit>().getWishlist();
                  },
                  icon: const Icon(Icons.refresh),
                ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (state.status.isInitial) {
                      context.read<WishlistCubit>().getWishlist();
                      return loader();
                    } else if (state.status.isLoading) {
                      return loader();
                    } else if (state.wishlist.isEmpty) {
                      return emptyWishlist(context);
                    }
                    return FetchMoreIndicator(
                      onAction: () async {
                        await context.read<WishlistCubit>().getWishlist();
                      },
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 20.h,
                        ),
                        itemBuilder: (context, index) {
                          Wishlist wishlist = state.wishlist[index];
                          return ExploreListTile(
                            itemId: wishlist.itemId,
                            itemType: wishlist.itemType,
                            img: wishlist.productImageUrls.firstOrNull,
                            genericName: wishlist.brandName ?? '',
                            name: wishlist.name,
                            price: wishlist.price,
                            prevPrice: wishlist.oldPrice,
                            rating: wishlist.averageRating?.round() ?? 0,
                            onTap: () {
                              if (wishlist.itemType.isProduct) {
                                Navigator.push(
                                  context,
                                  AppUtils.transition(
                                    ProductDetailPage(
                                      productId: wishlist.itemId,
                                    ),
                                  ),
                                );
                              }
                            },
                            // addWishlist:
                            //     () => _removeWishlist(context, wishlist),
                          );
                        },
                        separatorBuilder: (context, index) => 25.verticalSpace,
                        itemCount: state.wishlist.length,
                      ),
                    );
                  },
                ),
              ),
              // if (state.wishlist.isNotEmpty)
              //   Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 16.w),
              //     child: AppButton.primary(
              //       text: "Order Wishlist",
              //       onTap: () {
              //         //
              //       },
              //     ),
              //   ),
              32.verticalSpace,
            ],
          ),
        );
      },
    );
  }

  Column emptyWishlist(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.favorite_border_rounded,
          size: 120.sp,
          color: AppColor.darkGrey.withOpacity(0.3),
        ),
        24.verticalSpace,
        AppText.sp20("Your Wishlist is Empty").w600.black,
        8.verticalSpace,
        AppText.sp14(
          "Add items you love to your wishlist",
        ).w400.copyWith(color: AppColor.darkGrey),
        32.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.w),
          child: AppButton.primary(
            text: "Start Shopping",
            onTap: () {
              Navigator.pop(context);
              // AppUtils.tabController?.jumpToTab(0);
            },
          ),
        ),
      ],
    );
  }

  Padding loader() {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: const SearchLoader(length: 3),
    );
  }

  Future<void> orderWishlist(BuildContext context) async {
    // final wishlistCubit = context.read<WishlistCubit>();
    // wishlistCubit.state.wishlist;
    // List<CartItem> cartItems = wishlistCubit.state.wishlist.map((wishlistItem) {
    //   return CartItem(
    //     itemId: wishlistItem.itemId,
    //     name: wishlistItem.name,
    //     size: wishlistItem.,
    //     itemType: wishlistItem.itemType,
    //     quantity: 1,
    //     price: wishlistItem.price,
    //   );
    // }).toList();
    // final success = await wishlistCubit.addWishlistToCart();
    // if (success) {
    //   AppToast.showSuccess(
    //     context,
    //     "All items in your wishlist have been added to your cart.",
    //   );
    // } else {
    //   AppToast.showError(
    //     context,
    //     "Failed to add items from wishlist to cart. Please try again.",
    //   );
    // }
  }
}
