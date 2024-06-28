import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/extensions/widget_extension.dart';
import 'package:drugs_ng/core/ui/app_button.dart';
import 'package:drugs_ng/core/ui/app_text.dart';
import 'package:drugs_ng/core/ui/app_text_field.dart';
import 'package:drugs_ng/core/ui/location_chip.dart';
import 'package:drugs_ng/core/ui/product_card_widget.dart';
import 'package:drugs_ng/features/home/presentation/widgets/home_carousel_widget.dart';
import 'package:drugs_ng/features/home/presentation/widgets/order_prescription_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: RefreshIndicator(
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: const ProductCardWidget(
                          image: AppImage.molfix,
                          name: "image",
                          category: "Category",
                          price: 23,
                          rating: 2,
                          totalRating: 23,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => 15.horizontalSpace,
                    itemCount: 12),
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
                      return Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: const ProductCardWidget(
                          image: AppImage.syrup,
                          name: "image",
                          category: "category",
                          price: 23,
                          rating: 2,
                          totalRating: 23,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => 15.horizontalSpace,
                    itemCount: 12),
              ),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> reload() async {}

  void search() {}
  void notification() {}
  void cart() {}

  void viewAllNewArrivals() {}
  void viewAllBestSellers() {}
}
