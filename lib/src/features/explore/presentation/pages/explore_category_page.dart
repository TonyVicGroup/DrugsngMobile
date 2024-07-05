import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/data/models/product.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/explore/presentation/bloc/explore_bloc/explore_bloc.dart';
import 'package:drugs_ng/src/features/explore/presentation/bloc/explore_filter/explore_filter_bloc.dart';
import 'package:drugs_ng/src/features/explore/presentation/pages/explore_filters_page.dart';
import 'package:drugs_ng/src/features/explore/presentation/pages/explore_search_page.dart';
import 'package:drugs_ng/src/features/explore/presentation/widgets/category_filter_widget.dart';
import 'package:drugs_ng/src/features/explore/presentation/widgets/explore_grid_tile.dart';
import 'package:drugs_ng/src/features/explore/presentation/widgets/explore_list_tile.dart';
import 'package:drugs_ng/src/features/explore/presentation/widgets/explore_sort_modal.dart';
import 'package:drugs_ng/src/features/product/presentation/pages/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreCategoryPage extends StatefulWidget {
  const ExploreCategoryPage({super.key});

  @override
  State<ExploreCategoryPage> createState() => _ExploreCategoryPageState();
}

class _ExploreCategoryPageState extends State<ExploreCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreBloc, ExploreState>(
      builder: (context, state) {
        return BlocBuilder<ExploreFilterBloc, ExploreFilterState>(
          builder: (context, filterState) {
            if (state is ExploreLoading) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is ExploreSuccess) {
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
                  title: AppText.sp18("General Health").w700.black,
                  centerTitle: true,
                  actions: [
                    InkWell(
                      onTap: search,
                      child: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: SizedBox(
                          width: 24.r,
                          height: 24.r,
                          child: SvgPicture.asset(AppSvg.search),
                        ),
                      ),
                    ),
                    10.horizontalSpace,
                  ],
                  bottom: PreferredSize(
                    preferredSize: Size(double.maxFinite, 100.h),
                    child: SizedBox(
                      height: 100.h,
                      child: Column(
                        children: [
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: Row(
                              children: [
                                _allergy(),
                                const Spacer(),
                                _filterButton(),
                                const Spacer(),
                                _sortButton(state.sortType.displayName),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<ExploreBloc>()
                                        .add(ToggleGridEvent());
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 2.h,
                                    ),
                                    child: SvgPicture.asset(
                                      state.isGrid ? AppSvg.list : AppSvg.grid,
                                      width: 17.w,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 28.h,
                            width: double.maxFinite,
                            child: ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                String tag = filterState.tags[index];
                                return CategoryFilterWidget(
                                    text: tag, onTap: () {});
                              },
                              separatorBuilder: (context, index) =>
                                  15.horizontalSpace,
                              itemCount: filterState.tags.length,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                body: _appBody(state.isGrid, filterState.products),
              );
            } else {
              return Scaffold(
                body: Center(
                  child: AppText.sp18("Something went wrong"),
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget _appBody(bool isGrid, List<Product> products) {
    if (isGrid) {
      return GridView.builder(
        itemCount: products.length,
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.71,
          crossAxisSpacing: 18.w,
          mainAxisSpacing: 25.h,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return ExploreGridTile(
            img: product.image,
            rating: product.rating,
            totalRating: product.ratingCount,
            category: product.category,
            name: product.name,
            price: product.price,
            prevPrice: product.prevPrice,
            percentReduction: product.discountPercent,
            onTap: () => openProduct(product),
          );
        },
      );
    } else {
      return ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
        itemBuilder: (context, index) {
          final product = products[index];
          return ExploreListTile(
            img: product.image,
            rating: product.rating,
            totalRating: product.ratingCount,
            category: product.category,
            name: product.name,
            price: product.price,
            prevPrice: product.prevPrice,
            percentReduction: product.discountPercent,
            onTap: () => openProduct(product),
          );
        },
        separatorBuilder: (context, index) => 25.verticalSpace,
        itemCount: products.length,
      );
    }
  }

  void openProduct(Product product) {
    Navigator.push(
      context,
      AppUtils.transition(
        ProductDetailPage(
          product: product,
        ),
      ),
    );
  }

  InkWell _filterButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          AppUtils.transition(const ExploreFiltersPage()),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppSvg.filters,
            height: 12.h,
            width: 18.w,
          ),
          8.horizontalSpace,
          AppText.sp14("Filters").w400.black,
        ],
      ),
    );
  }

  InkWell _sortButton(String sortType) {
    return InkWell(
      onTap: () async {
        await showModalBottomSheet(
          context: AppUtils.navKey.currentContext!,
          builder: (context) {
            return const ExploreSortModal();
          },
          isScrollControlled: true,
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppSvg.sortBy,
            height: 18.h,
            width: 14.w,
          ),
          8.horizontalSpace,
          AppText.sp14(sortType).w400.black,
        ],
      ),
    );
  }

  InkWell _allergy() {
    return InkWell(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.sp14("Allergy").w400.black,
          8.horizontalSpace,
          RotatedBox(
            quarterTurns: 3,
            child: SvgPicture.asset(
              AppSvg.chevronThick,
              height: 15.w,
              width: 14.w,
            ),
          ),
        ],
      ),
    );
  }

  void search() {
    Navigator.push(
      context,
      AppUtils.transition(const ExploreSearchPage()),
    );
  }
}
