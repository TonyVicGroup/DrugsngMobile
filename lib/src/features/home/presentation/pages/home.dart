import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/extensions/widget_extension.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/ui/app_text_field.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/checkout/presentation/pages/cart_page.dart';
import 'package:drugs_ng/src/features/explore/presentation/pages/explore_search_page.dart';
import 'package:drugs_ng/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:drugs_ng/src/features/product/domain/models/product.dart';
import 'package:drugs_ng/src/features/home/presentation/widgets/location_chip.dart';
import 'package:drugs_ng/src/features/home/presentation/widgets/product_card_widget.dart';
import 'package:drugs_ng/src/features/home/presentation/widgets/home_carousel_widget.dart';
import 'package:drugs_ng/src/features/home/presentation/widgets/order_prescription_widget.dart';
import 'package:drugs_ng/src/features/notification/presentation/pages/notification_page.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: reload,
            child: SafeArea(
              bottom: false,
              child: ListView(
                children: [
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        const LocationChip(),
                        const Spacer(),
                        Row(
                          children: [
                            AppButton.svgIcon(
                              svg: AppSvg.notification,
                              onTap: notification,
                            ),
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
                  const HomeCarouselWidget(),
                  30.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.sp16("New Arrivals").w500.black,
                        AppText.sp14("View All")
                            .w400
                            .primaryColor
                            .clickable(viewAllNewArrivals),
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
                            image: arrive.imageUrls.first,
                            name: arrive.name,
                            genericName: arrive.genericName,
                            price: arrive.price,
                            // prevPrice: arrive.prevPrice,
                            // rating: arrive.rating,
                            // totalRating: arrive.ratingCount,
                            // percentReduction: arrive.discountPercent,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => 15.horizontalSpace,
                      itemCount: state.data.newArrivals.length,
                    ),
                  ),
                  30.verticalSpace,
                  const OrderPrescriptionWidget(),
                  30.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.sp16("Best Sellers").w500.black,
                        AppText.sp14("View All")
                            .w400
                            .primaryColor
                            .clickable(viewAllBestSellers),
                      ],
                    ),
                  ),
                  12.verticalSpace,
                  SizedBox(
                    height: 273.h,
                    child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          Product bSell = state.data.bestSellers[index];
                          return Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: ProductCardWidget(
                              image: bSell.imageUrls.first,
                              name: bSell.name,
                              genericName: bSell.genericName,
                              price: bSell.price,
                              // prevPrice: bSell.prevPrice,
                              // rating: bSell.rating,
                              // percentReduction: bSell.discountPercent,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            15.horizontalSpace,
                        itemCount: state.data.bestSellers.length),
                  ),
                  30.verticalSpace,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> reload() async {
    await context.read<HomeCubit>().reloadData();
  }

  void search() {
    Navigator.push(
      context,
      AppUtils.transition(const ExploreSearchPage()),
    );
  }

  void notification() {
    Navigator.push(
      context,
      AppUtils.transition(const NotificationPage()),
    );
  }

  void cart() {
    Navigator.push(
      context,
      AppUtils.transition(const CartPage()),
    );
  }

  void viewAllNewArrivals() {}

  void viewAllBestSellers() {}
}
