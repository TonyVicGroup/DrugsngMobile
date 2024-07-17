import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/ui/app_text_field.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/checkout/presentation/pages/cart_page.dart';
import 'package:drugs_ng/src/features/explore/domain/models/major_category.dart';
import 'package:drugs_ng/src/features/explore/presentation/bloc/explore_bloc/explore_bloc.dart';
// import 'package:drugs_ng/src/features/explore/domain/entity/explore_category_data.dart';
import 'package:drugs_ng/src/features/explore/presentation/cubit/explore_major_category_cubit.dart';
import 'package:drugs_ng/src/features/explore/presentation/pages/explore_category_page.dart';
import 'package:drugs_ng/src/features/explore/presentation/pages/explore_search_page.dart';
import 'package:drugs_ng/src/features/explore/presentation/widgets/explore_category_widget.dart';
import 'package:drugs_ng/src/features/home/presentation/widgets/location_chip.dart';
import 'package:drugs_ng/src/features/notification/presentation/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ExploreMajorCategoryCubit, ExploreMajorCategoryState>(
        bloc: context.read<ExploreMajorCategoryCubit>(),
        builder: (context, state) {
          if (state is ExploreMajorCategoryInitial) {
            context.read<ExploreMajorCategoryCubit>().getCategories();
          }
          if (state is ExploreMajorCategoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ExploreMajorCategorySuccess) {
            return SafeArea(
              child: Column(
                children: [
                  16.verticalSpace,
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
                              onTap: () => notification(context),
                            ),
                            15.horizontalSpace,
                            AppButton.svgIcon(
                              svg: AppSvg.shopping,
                              onTap: () => cart(context),
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
                      onTap: () => search(context),
                    ),
                  ),
                  30.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        AppText.sp16("Major Categories").w500.black,
                        const Spacer(),
                        DropdownButton(
                          value: state.categoryType,
                          alignment: Alignment.centerRight,
                          underline: const SizedBox.shrink(),
                          elevation: 1,
                          padding: EdgeInsets.zero,
                          dropdownColor: AppColor.white,
                          icon: Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: SvgPicture.asset(
                                AppSvg.chevronThick,
                                width: 10.w,
                                height: 10.w,
                                colorFilter: const ColorFilter.mode(
                                    AppColor.black, BlendMode.srcIn),
                              ),
                            ),
                          ),
                          items: MajorCategoryType.values
                              .map((cat) => DropdownMenuItem(
                                    value: cat,
                                    child: AppText.sp14(cat.displayName)
                                        .w400
                                        .black,
                                  ))
                              .toList(),
                          onChanged: (catType) {
                            if (catType != null) {
                              context
                                  .read<ExploreMajorCategoryCubit>()
                                  .changeCategoryType(catType);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  22.verticalSpace,
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
                      itemBuilder: (context, index) {
                        final MajorCategory category =
                            state.categoryList[index];
                        return ExploreCategoryWidget(
                          img: category.url,
                          title: category.name,
                          subtitle: category.description,
                          onTap: () {
                            context.read<ExploreBloc>().add(
                                RefreshCategoryEvent(
                                    categoryType: state.categoryType,
                                    forceReload: false));
                            Navigator.push(
                              context,
                              AppUtils.transition(const ExploreCategoryPage()),
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => 20.verticalSpace,
                      itemCount: state.categoryList.length,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: AppText.sp16("Some error occured"),
            );
          }
        },
      ),
    );
  }

  void search(BuildContext context) {
    Navigator.push(
      context,
      AppUtils.transition(const ExploreSearchPage()),
    );
  }

  void notification(BuildContext context) {
    Navigator.push(
      context,
      AppUtils.transition(const NotificationPage()),
    );
  }

  void cart(BuildContext context) {
    Navigator.push(
      context,
      AppUtils.transition(const CartPage()),
    );
  }
}
