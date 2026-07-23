import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/cubits/navigation_tab_cubit.dart';
import 'package:drugs_ng/core/enum/item_type_enum.dart';
import 'package:drugs_ng/core/enum/sort_type_enum.dart';
import 'package:drugs_ng/core/services/location_service.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/textfield/app_text_field.dart';
import 'package:drugs_ng/core/widgets/error_banner.dart';
import 'package:drugs_ng/core/widgets/error_page.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/cart_page.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/wishlist_cubit.dart';
import 'package:drugs_ng/features/search/data/models/search_item.dart';
import 'package:drugs_ng/features/search/presentation/pages/search_page.dart';
import 'package:drugs_ng/features/home/presentation/cubit/home_cubit.dart';
import 'package:drugs_ng/features/home/presentation/widgets/homepage_loader.dart';
import 'package:drugs_ng/features/product/domain/models/product.dart';
import 'package:drugs_ng/features/home/presentation/widgets/location_chip.dart';
import 'package:drugs_ng/features/home/presentation/widgets/product_card_widget.dart';
import 'package:drugs_ng/features/home/presentation/widgets/home_carousel_widget.dart';
import 'package:drugs_ng/features/home/presentation/widgets/order_prescription_widget.dart';
import 'package:drugs_ng/features/notification/presentation/pages/notification_page.dart';
import 'package:drugs_ng/features/product/presentation/pages/product_detail_page.dart';
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
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: reload,
            displacement: 64.h,
            child: SafeArea(
              bottom: false,
              child:
                  (state.isEmpty && state is HomeError)
                      ? ErrorPage(message: state.error.message)
                      : ListView(
                        children: [
                          if (state is HomeError)
                            ErrorBanner(
                              text:
                                  "${state.error.message}. Pull down to refresh",
                            ),
                          16.verticalSpace,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              children: [
                                LocationChip.widget(context),
                                const Spacer(),
                                Row(
                                  children: [
                                    // AppButton.svgIcon(
                                    //   svg: AppSvg.notification,
                                    //   onTap: notification,
                                    // ),
                                    15.horizontalSpace,
                                    AppButton.svgIcon(
                                      svg: AppSvg.shopping,
                                      onTap: cart,
                                      color: AppColor.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          30.verticalSpace,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: AppTextField.search(
                              hint: "Search for health products and tests",
                              onTap: search,
                            ),
                          ),
                          30.verticalSpace,
                          if (state is HomeLoading)
                            const HomepageLoader()
                          else
                            ...homePageData(state),
                        ],
                      ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> homePageData(HomeState state) {
    return [
      if (state.data.homeAds.isNotEmpty) ...[
        HomeCarouselWidget(ads: state.data.homeAds),
        30.verticalSpace,
      ],
      if (state.data.newArrivals.isNotEmpty) ...[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.sp16("New Arrivals").w500.black,
              // AppText.sp14("View All").w400.primaryColor.clickable(
              //     () => _moveToCategory(context, SortTypeEnum.newArrival)),
            ],
          ),
        ),
        12.verticalSpace,
        SizedBox(
          height: 273.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Product arrive = state.data.newArrivals[index];
              return Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: ProductCardWidget(
                  image: arrive.imageUrls.firstOrNull,
                  name: arrive.name,
                  itemId: arrive.id,
                  genericName: arrive.genericName,
                  price: arrive.price,
                  rating: arrive.rating,
                  onTap: () => _openProductPage(arrive),
                  itemType: ItemTypeEnum.product,
                ),
              );
            },
            separatorBuilder: (context, index) => 16.horizontalSpace,
            itemCount: state.data.newArrivals.length,
          ),
        ),
        30.verticalSpace,
      ],
      const OrderPrescriptionWidget(),
      30.verticalSpace,
      if (state.data.bestSellers.isNotEmpty) ...[
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
          height: 273.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Product bSell = state.data.bestSellers[index];
              return Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: ProductCardWidget(
                  image: bSell.imageUrls.firstOrNull,
                  name: bSell.name,
                  itemId: bSell.id,
                  genericName: bSell.genericName,
                  price: bSell.price,
                  rating: bSell.rating,
                  onTap: () => _openProductPage(bSell),
                  itemType: ItemTypeEnum.product,
                  // onLike: () async {
                  //   await _addToWishlist(bSell);
                  // },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return 16.horizontalSpace;
            },
            itemCount: state.data.bestSellers.length,
          ),
        ),
        30.verticalSpace,
      ],
    ];
  }

  Future<void> reload() async {
    await context.read<HomeCubit>().reloadData();
  }

  Future _nextPage(Widget page) async {
    context.read<NavigationTabCubit>().hide();
    await Navigator.push(context, AppUtils.transition(page));
    // ignore: use_build_context_synchronously
    context.read<NavigationTabCubit>().show();
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
    _nextPage(ProductDetailPage(productId: product.id));
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
