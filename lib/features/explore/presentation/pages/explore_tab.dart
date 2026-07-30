import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/error_banner.dart';
import 'package:drugs_ng/core/widgets/error_page.dart';
import 'package:drugs_ng/core/widgets/textfield/border_text_field.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/cart_page.dart';
import 'package:drugs_ng/features/explore/domain/models/major_category.dart';
import 'package:drugs_ng/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:drugs_ng/features/explore/presentation/cubit/explore_major_category_cubit.dart';
import 'package:drugs_ng/features/explore/presentation/pages/explore_category_page.dart';
import 'package:drugs_ng/features/home/presentation/widgets/home_header_widget.dart';
import 'package:drugs_ng/features/profile/presentation/widgets/login_required_modal.dart';
import 'package:drugs_ng/features/search/data/models/search_item.dart';
import 'package:drugs_ng/features/search/presentation/pages/search_page.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/explore_category_widget.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/major_category_loader.dart';
import 'package:drugs_ng/features/notification/presentation/pages/notification_page.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<
          ExploreMajorCategoryCubit,
          ExploreMajorCategoryState
        >(
          bloc: context.read<ExploreMajorCategoryCubit>(),
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<ExploreMajorCategoryCubit>().getCategories();
              },
              child:
                  (state.isEmpty && state.status.isFailed)
                      ? ErrorPage(
                        message: state.error,
                        onRetry:
                            () =>
                                context
                                    .read<ExploreMajorCategoryCubit>()
                                    .getCategories(),
                      )
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
                          10.verticalSpace,
                          Builder(
                            builder: (context) {
                              if (state.status.isInitial) {
                                context
                                    .read<ExploreMajorCategoryCubit>()
                                    .getCategories();
                                return const MajorCategoryLoader();
                              } else if (state.status.isLoading) {
                                return const MajorCategoryLoader();
                              } else if (state.status.isSuccess) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                      ),
                                      child: Row(
                                        children: [
                                          AppText.sp16(
                                            "Major Categories",
                                          ).w500.black,
                                          const Spacer(),
                                          DropdownButton(
                                            value: state.categoryType,
                                            alignment: Alignment.centerRight,
                                            underline: const SizedBox.shrink(),
                                            elevation: 1,
                                            padding: EdgeInsets.zero,
                                            dropdownColor: AppColor.white,
                                            icon: Padding(
                                              padding: EdgeInsets.only(
                                                left: 2.w,
                                              ),
                                              child: RotatedBox(
                                                quarterTurns: 3,
                                                child: SvgPicture.asset(
                                                  AppSvg.chevronThick,
                                                  width: 10.sp,
                                                  height: 10.sp,
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                        AppColor.black,
                                                        BlendMode.srcIn,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            items:
                                                MajorCategoryType.values
                                                    .map(
                                                      (cat) => DropdownMenuItem(
                                                        value: cat,
                                                        child:
                                                            AppText.sp14(
                                                              cat.displayName,
                                                            ).w400.black,
                                                      ),
                                                    )
                                                    .toList(),
                                            onChanged: (catType) {
                                              if (catType != null) {
                                                context
                                                    .read<
                                                      ExploreMajorCategoryCubit
                                                    >()
                                                    .changeCategoryType(
                                                      catType,
                                                    );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),

                                    Builder(
                                      builder: (context) {
                                        if (state.categoryList.isEmpty) {
                                          return _emptyCategoryWidget(
                                            "No major categories found",
                                          );
                                        }
                                        return ListView.separated(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: EdgeInsets.fromLTRB(
                                            16.w,
                                            0,
                                            16.w,
                                            20.h,
                                          ),
                                          itemBuilder: (context, index) {
                                            final MajorCategory category =
                                                state.categoryList[index];
                                            return ExploreCategoryWidget(
                                              img: category.url,
                                              title: category.name,
                                              subtitle: category.description,
                                              onTap: () {
                                                ExploreCubit bloc =
                                                    context
                                                        .read<ExploreCubit>();
                                                // update filter with current category
                                                final filter = bloc
                                                    .state
                                                    .data
                                                    .filter
                                                    .copy(category: category);
                                                // update filter information and refresh the data
                                                bloc.updateFilter(filter);
                                                _nextPage(
                                                  context,
                                                  const ExploreCategoryPage(),
                                                );
                                              },
                                            );
                                          },
                                          separatorBuilder:
                                              (context, index) =>
                                                  20.verticalSpace,
                                          itemCount: state.categoryList.length,
                                        );
                                      },
                                    ),
                                  ],
                                );
                              }
                              if (state.status.isFailed) {
                                return _errorContainer(
                                  state.error ?? 'App error',
                                );
                              }
                              return _errorContainer(AppError.unknown.message);
                            },
                          ),
                        ],
                      ),
            );
          },
        ),
      ),
    );
  }

  SizedBox _errorContainer(String message) {
    return SizedBox(height: 300.h, child: Center(child: AppText.sp16(message)));
  }

  Future _nextPage(BuildContext context, Widget page) async {
    // context.read<NavigationTabCubit>().hide();
    // await Navigator.push(context, AppUtils.transition(page));
    // // ignore: use_build_context_synchronously
    // context.read<NavigationTabCubit>().show();
  }

  void search(BuildContext context) {
    _nextPage(context, const SearchPage(searchType: SearchType.product));
  }

  void notification(BuildContext context) {
    _nextPage(context, const NotificationPage());
  }

  void cart(BuildContext context) {
    if (context.read<AuthCubit>().isLoggedIn) {
      _nextPage(context, const CartPage());
      return;
    } else {
      LoginRequiredModal.show(context);
    }
  }

  Widget _emptyCategoryWidget(String message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60.h, horizontal: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(24.sp),
            decoration: BoxDecoration(
              color: AppColor.black.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              AppSvg.doctorFilter,
              width: 48.sp,
              height: 48.sp,
              colorFilter: ColorFilter.mode(
                AppColor.black.withOpacity(0.3),
                BlendMode.srcIn,
              ),
            ),
          ),
          24.verticalSpace,
          AppText.sp18(message).w600.black.centerText,
          8.verticalSpace,
          AppText.sp14(
            "We couldn't find any categories at the moment.\nPlease try again later.",
          ).w400.copyWith(color: AppColor.black.withOpacity(0.6)).centerText,
        ],
      ),
    );
  }
}
