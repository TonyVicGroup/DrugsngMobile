import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/enum/item_type_enum.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/generic/custom_appbar_widget.dart';
import 'package:drugs_ng/core/widgets/textfield/border_text_field.dart';
import 'package:drugs_ng/features/lab_test/presentation/pages/package_overview_page.dart';
import 'package:drugs_ng/features/lab_test/presentation/pages/test_overview_page.dart';
import 'package:drugs_ng/features/product/domain/models/product_detail.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/search/data/models/search_item.dart';
import 'package:drugs_ng/features/search/presentation/cubit/search_cubit.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/explore_list_tile.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/explore_search_field.dart';
import 'package:drugs_ng/features/product/presentation/pages/product_detail_page.dart';
import 'package:drugs_ng/features/search/presentation/pages/search_loader.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatefulWidget {
  final SearchType searchType;
  const SearchPage({super.key, required this.searchType});

  @override
  State<SearchPage> createState() => _SearchPageState();

  static Route<dynamic> route(RouteSettings settings) {
    return MaterialPageRoute(
      builder:
          (context) => SearchPage(searchType: settings.arguments as SearchType),
    );
  }
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        appBar: CustomAppBarWidget(title: "Search"),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  10.verticalSpace,
                  BorderTextField(
                    borderRadius: 50.r,
                    controller: controller,
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
                    hint: 'Search...',
                    // onTap: () {
                    //   // context.pushNamed(
                    //   //   AppRoutes.searchPage,
                    //   //   arguments: SearchType.product,
                    //   // );
                    // },
                  ),
                  // ExploreSearchField(
                  //   controller: controller,
                  //   onChanged: (value) {
                  //     // search(context, value ?? "");
                  //   },
                  //   onSubmitted: (value) {
                  //     search(context, value ?? "");
                  //   },
                  // ),
                  20.verticalSpace,
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (state.status.isInitial) {
                          return Center(
                            child: AppText.sp16(
                              "Enter your search in the search field",
                            ),
                          );
                        } else if (state.status.isLoading) {
                          return SearchLoader(
                            length: state.searchResult.length,
                          );
                        } else if (state.status.isFailed &&
                            state.searchResult.isEmpty) {
                          // if there is no item with the query
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.close, size: 10.r),
                              10.verticalSpace,
                              AppText.sp16("No Item was found in the search"),
                            ],
                          );
                        } else {
                          return ListView.separated(
                            padding: EdgeInsets.fromLTRB(
                              16.w,
                              16.h,
                              16.w,
                              80.h,
                            ),
                            itemBuilder: (context, index) {
                              SearchItem item = state.searchResult[index];
                              return ExploreListTile(
                                itemId: item.id,
                                itemType: ItemTypeEnum.product,
                                img: item.image ?? "",
                                rating: item.rating?.round() ?? 0,
                                genericName: item.subtitle,
                                name: item.name,
                                price: item.price,
                                onTap: () => openItem(item.id, item.searchType),
                                // addWishlist:
                                //     () => _addToWishlist(
                                //       item.id,
                                //       item.searchType.name,
                                //     ),
                              );
                            },
                            separatorBuilder:
                                (context, index) => 25.verticalSpace,
                            itemCount: state.searchResult.length,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future search(BuildContext context, String query) async {
    await context.read<SearchCubit>().search(query, widget.searchType);
  }

  void openItem(int id, SearchType type) {
    switch (type) {
      case SearchType.product:
        Navigator.push(
          context,
          AppUtils.transition(ProductDetailPage(productId: id)),
        );
        break;
      case SearchType.diagnosticTest:
        Navigator.push(
          context,
          AppUtils.transition(TestOverviewPage(productId: id)),
        );
        break;
      case SearchType.wellnessPackage:
        Navigator.push(
          context,
          AppUtils.transition(PackageOverviewPage(productId: id)),
        );
        break;
      default:
        break;
    }
  }

  void openProduct(BuildContext context, ProductDetail product) {
    Navigator.push(
      context,
      AppUtils.transition(ProductDetailPage(productId: product.id)),
    );
  }
}
