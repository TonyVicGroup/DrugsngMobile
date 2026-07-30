import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/item_type_enum.dart';
import 'package:drugs_ng/core/enum/sort_type_enum.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/extensions/widget_extension.dart';
import 'package:drugs_ng/core/navigation/app_route.dart';
import 'package:drugs_ng/core/services/location_service.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/textfield/app_text_field.dart';
import 'package:drugs_ng/core/widgets/error_banner.dart';
import 'package:drugs_ng/core/widgets/error_page.dart';
import 'package:drugs_ng/core/widgets/textfield/border_text_field.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/cart_page.dart';
import 'package:drugs_ng/features/home/presentation/widgets/home_header_widget.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/wishlist_cubit.dart';
import 'package:drugs_ng/features/search/data/models/search_item.dart';
import 'package:drugs_ng/features/search/presentation/pages/search_page.dart';
import 'package:drugs_ng/features/home/presentation/cubit/home_cubit.dart';
import 'package:drugs_ng/features/home/presentation/widgets/homepage_loader.dart';
import 'package:drugs_ng/features/product/domain/models/product.dart';
import 'package:drugs_ng/features/home/presentation/widgets/location_chip.dart';
import 'package:drugs_ng/features/home/presentation/widgets/product_card_widget.dart';
import 'package:drugs_ng/features/home/presentation/widgets/order_prescription_widget.dart';
import 'package:drugs_ng/features/notification/presentation/pages/notification_page.dart';
import 'package:drugs_ng/features/product/presentation/pages/product_detail_page.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LocationService.requestLocationPermission();
      context.read<WishlistCubit>().getWishlist();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: reload,
          displacement: 64.h,
          child: SafeArea(
            bottom: false,
            child:
                (state.isEmpty && state.status.isFailed)
                    ? ErrorPage(message: state.error)
                    : ListView(
                      children: [
                        if (state.status.isFailed)
                          ErrorBanner(
                            text: "${state.error}. Pull down to refresh",
                          ),
                        16.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: HomeHeaderWidget(),
                        ),
                        10.verticalSpace,

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: BorderTextField(
                            borderRadius: 50.r,
                            borderColor: AppColor.colorE5E5E5,
                            filled: true,
                            fillColor: AppColor.colorFFFFFF,
                            prefixIcon: SizedBox(
                              width: 20.w,
                              child: Center(
                                child: CustomImage(
                                  Assets.svg.search,
                                  color: AppColor.color555555,
                                  width: 20.r,
                                  height: 20.r,
                                ),
                              ),
                            ),
                            hint: 'Search for health products and tests...',
                          ),
                        ),
                        30.verticalSpace,
                        if (state.status.isLoading)
                          const HomepageLoader()
                        else
                          ...homePageData(state),
                      ],
                    ),
          ),
        );
      },
    );
  }

  List<Widget> homePageData(HomeState state) {
    return [
      // if (state.data.homeAds.isNotEmpty) ...[
      //   HomeCarouselWidget(ads: state.data.homeAds),
      //   30.verticalSpace,
      // ],
      if (state.newArrivals.isNotEmpty) ...[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.sp16("New Arrivals").w500.black,
              AppText.sp14("View All").w400
                  .setColor(AppColor.color0B8AE1)
                  .clickable(
                    () => _moveToCategory(context, SortTypeEnum.newArrival),
                  ),
            ],
          ),
        ),
        12.verticalSpace,
        SizedBox(
          height: 289.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Product arrive = state.newArrivals[index];
              return ProductCardWidget(
                image: arrive.imageUrls.firstOrNull,
                name: arrive.name,
                itemId: arrive.id,
                genericName: arrive.genericName,
                price: arrive.price,
                rating: arrive.rating,
                onTap: () => _openProductPage(arrive),
                itemType: ItemTypeEnum.product,
              );
            },
            separatorBuilder: (context, index) => 16.horizontalSpace,
            itemCount: state.newArrivals.length,
          ),
        ),
        10.verticalSpace,
      ],
      10.verticalSpace,
      const OrderPrescriptionWidget().padSymmetric(horizontal: 16.w),
      30.verticalSpace,
      if (state.bestSellers.isNotEmpty) ...[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.sp16("Best Sellers").w500.black,
              // AppText.sp14("View All")
              //     .w400
              //     .primaryColor
              //     .clickable(viewAllBestSellers),
            ],
          ),
        ),
        12.verticalSpace,
        SizedBox(
          height: 289.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Product bSell = state.bestSellers[index];
              return ProductCardWidget(
                image: bSell.imageUrls.firstOrNull,
                name: bSell.name,
                itemId: bSell.id,
                genericName: bSell.genericName,
                price: bSell.price,
                rating: bSell.rating,
                onTap: () => _openProductPage(bSell),
                itemType: ItemTypeEnum.product,
              );
            },
            separatorBuilder: (context, index) {
              return 16.horizontalSpace;
            },
            itemCount: state.bestSellers.length,
          ),
        ),
        100.verticalSpace,
      ],
    ];
  }

  Future<void> reload() async {
    await context.read<HomeCubit>().getData(showLoader: false);
  }

  Future _nextPage(Widget page) async {
    // context.read<NavigationTabCubit>().hide();
    // await Navigator.push(context, AppUtils.transition(page));
    // // ignore: use_build_context_synchronously
    // context.read<NavigationTabCubit>().show();
  }

  void search() {
    _nextPage(const SearchPage(searchType: SearchType.all));
  }

  void notification() {
    _nextPage(const NotificationPage());
  }

  void cart() {
    _nextPage(const CartPage());
  }

  // void viewAllNewArrivals() {
  //   _moveToCategory(SortTypeEnum.newArrival);
  // }

  void viewAllBestSellers() {}

  void _openProductPage(Product product) {
    context.pushNamed(AppRoutes.productDetailScreen, arguments: product.id);
  }

  // Future _addToWishlist(Product product) async {
  //   final result = await context.read<WishlistCubit>().addWishlist(
  //     product.id,
  //     'product',
  //   );
  //   if (result) {
  //     // ignore: use_build_context_synchronously
  //     AppToast.success(context, "${product.name} added to wishlist");
  //   }
  // }

  void _moveToCategory(BuildContext context, SortTypeEnum sortType) {}
}
