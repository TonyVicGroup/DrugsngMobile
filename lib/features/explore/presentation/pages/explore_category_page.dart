import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/item_type_enum.dart';
import 'package:drugs_ng/core/extensions/string_extension.dart';
import 'package:drugs_ng/core/widgets/error_reload_widget.dart';
import 'package:drugs_ng/core/widgets/fetch_more_indicator.dart';
import 'package:drugs_ng/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/explore_category_loader.dart';
import 'package:drugs_ng/features/product/domain/models/product_detail.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/explore/presentation/pages/explore_filters_page.dart';
import 'package:drugs_ng/features/search/data/models/search_item.dart';
import 'package:drugs_ng/features/search/presentation/pages/search_page.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/category_filter_widget.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/explore_grid_tile.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/explore_list_tile.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/explore_sort_modal.dart';
import 'package:drugs_ng/features/product/presentation/pages/product_detail_page.dart';
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
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        final height = state.data.filter.filterTags.isEmpty ? 72.h : 100.h;

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
            title:
                AppText.sp18(
                  state.data.filter.category.name.capitalizeFirstofEach,
                ).w700.black,
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
              preferredSize: Size(double.maxFinite, height),
              child: SizedBox(
                height: height,
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
                          // _sortButton(state.data.sortType.displayName),
                          // const Spacer(),
                          InkWell(
                            onTap: () {
                              context.read<ExploreCubit>().toggle();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 2.h,
                              ),
                              child: SvgPicture.asset(
                                state.data.displayType.isList
                                    ? AppSvg.list
                                    : AppSvg.grid,
                                width: 17.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    if (state.data.filter.filterTags.isNotEmpty)
                      SizedBox(
                        height: 28.h,
                        width: double.maxFinite,
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            String tag = state.data.filter.filterTags[index];
                            return CategoryFilterWidget(
                              text: tag,
                              onTap: () {},
                            );
                          },
                          separatorBuilder:
                              (context, index) => 16.horizontalSpace,
                          itemCount: state.data.filter.filterTags.length,
                        ),
                      ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
          body: Builder(
            builder: (context) {
              if (state is ExploreLoading) {
                return const ExploreCategoryLoader();
              } else if (state is ExploreFailed) {
                return Column(
                  children: [
                    const Spacer(flex: 2),
                    const Row(),
                    ErrorReloadWidget(
                      message: state.error.message,
                      onReload: () {
                        context.read<ExploreCubit>().refreshCategory(
                          state.data.categoryType,
                          true,
                        );
                      },
                    ),
                    const Spacer(flex: 3),
                  ],
                );
              } else {
                return FetchMoreIndicator(
                  onAction: () async {
                    await context.read<ExploreCubit>().nextPage();
                    setState(() {});
                  },
                  child: _appBody(),
                );
              }
            },
          ),
        );
      },
    );
  }

  Widget _appBody() {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        List<ProductDetail> products = state.data.products;
        if (products.isEmpty) {
          return _emptyProductsWidget();
        }
        if (state.data.displayType.isGrid) {
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
                itemId: product.id,
                itemType: ItemTypeEnum.product,
                image: product.imageUrls.firstOrNull,
                // totalRating: product.ratingCount,
                genericName: product.genericName,
                name: product.name,
                price: product.price,
                rating: product.averageRating.toInt(),
                // prevPrice: product.prevPrice,
                // percentReduction: product.discountPercent,
                onTap: () => openProduct(product),
                // addWishlist: () => _addToWishlist(product),
              );
            },
          );
        } else {
          return ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
            itemBuilder: (context, index) {
              final product = products[index];
              return ExploreListTile(
                itemId: product.id,
                itemType: ItemTypeEnum.product,
                img: product.imageUrls.firstOrNull,
                rating: product.averageRating.toInt(),
                // totalRating: product.ratingCount,
                genericName: product.genericName,
                name: product.name,
                price: product.price,
                // prevPrice: product.prevPrice,
                // percentReduction: product.discountPercent,
                onTap: () => openProduct(product),
                // addWishlist: () => _addToWishlist(product),
              );
            },
            separatorBuilder: (context, index) => 25.verticalSpace,
            itemCount: products.length,
          );
        }
      },
    );
  }

  Widget _emptyProductsWidget() {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(
          AppSvg.search,
          width: 80.w,
          height: 80.h,
          colorFilter: ColorFilter.mode(
            AppColor.black.withOpacity(0.3),
            BlendMode.srcIn,
          ),
        ),
        24.verticalSpace,
        AppText.sp18("No Products Found").w600.black,
        12.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: AppText.sp14(
            "We couldn't find any products in this category. Try adjusting your filters or explore other categories.",
          ).w400.copyWith(
            color: AppColor.black.withOpacity(0.6),
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }

  void openProduct(ProductDetail product) {
    Navigator.push(
      context,
      AppUtils.transition(ProductDetailPage(productId: product.id)),
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
          SvgPicture.asset(AppSvg.filters, height: 12.h, width: 18.w),
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
          builder: (context) => const ExploreSortModal(),
          isScrollControlled: true,
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AppSvg.sortBy, height: 18.h, width: 14.w),
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
              height: 15.sp,
              width: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  void search() {
    Navigator.push(
      context,
      AppUtils.transition(const SearchPage(searchType: SearchType.product)),
    );
  }
}
