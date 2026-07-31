import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/fetch_more_indicator.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/core/widgets/generic/custom_appbar_widget.dart';
import 'package:drugs_ng/core/widgets/generic/empty_widget.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/explore_list_tile.dart';
import 'package:drugs_ng/features/product/presentation/pages/product_detail_page.dart';
import 'package:drugs_ng/features/profile/data/models/wishlist.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/wishlist_cubit.dart';
import 'package:drugs_ng/features/search/presentation/pages/search_loader.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  static Route<dynamic> route(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const WishlistPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBarWidget(
            title: 'Wishlist',
            actions: [
              if (!state.status.isLoading)
                AppButtonAnimator(
                  onTap: () {
                    context.read<WishlistCubit>().getWishlist();
                  },
                  child: CustomImage(
                    Assets.svg.retryCircle,
                    width: 20.r,
                    color: AppColor.color333333,
                  ),
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

  Widget emptyWishlist(BuildContext context) {
    return EmptyWidget(
      title: "Your Wishlist is Empty",
      subtitle: "Add items you love to your wishlist",
      svg: AppSvg.heartOutline,
      buttonText: "Start Shopping",
      onTap: context.pop,
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
