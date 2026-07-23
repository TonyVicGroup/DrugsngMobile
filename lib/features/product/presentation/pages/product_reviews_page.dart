import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/rating_filter_enum.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/empty_review_widget.dart';
import 'package:drugs_ng/core/widgets/fetch_more_indicator.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/product/presentation/cubit/product_review_cubit.dart';
import 'package:drugs_ng/features/product/presentation/pages/new_review_page.dart';
import 'package:drugs_ng/features/product/presentation/widgets/product_review_loader.dart';
import 'package:drugs_ng/features/product/presentation/widgets/review_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductReviewsPage extends StatelessWidget {
  final int productId;

  const ProductReviewsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductReviewCubit(productId)..getProductReviews(),
      child: BlocBuilder<ProductReviewCubit, ProductReviewState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 5,
              shadowColor: Colors.black.withOpacity(0.2),
              surfaceTintColor: AppColor.white,
              backgroundColor: AppColor.white,
              leading: Center(
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: SizedBox(
                    width: 20.sp,
                    height: 20.sp,
                    child: SvgPicture.asset(AppSvg.chevronThick),
                  ),
                ),
              ),
              title: AppText.sp18("Product review").w700.black,
              centerTitle: true,
            ),
            body: Builder(
              builder: (context) {
                return FetchMoreIndicator(
                  onAction: context.read<ProductReviewCubit>().nextPage,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        20.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 32.h,
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: const Color(0xFFE5E5E5),
                                ),
                              ),
                              child: DropdownButton<RatingFilterEnum>(
                                value: state.stars,
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 22.r,
                                  color: const Color(0xFF8B96A5),
                                ),
                                underline: const SizedBox.shrink(),
                                items:
                                    RatingFilterEnum.allValues
                                        .map(
                                          (rating) => DropdownMenuItem(
                                            value: rating,
                                            child: AppText.sp12(
                                              rating.index == 0
                                                  ? "All-Stars "
                                                  : "${rating.index}-Stars ",
                                            ).w400.setColor(
                                              const Color(0xFF8B96A5),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (v) {
                                  if (v != null) {
                                    context.read<ProductReviewCubit>().filter(
                                      v,
                                    );
                                  }
                                },
                              ),
                            ),
                            _iconBtn(AppSvg.addReview, "Write a review", () {
                              Navigator.push(
                                context,
                                AppUtils.transition(
                                  BlocProvider.value(
                                    value: context.read<ProductReviewCubit>(),
                                    child: NewReviewPage(productId: productId),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              if (state.status.isLoading) {
                                return const ProductReviewLoader();
                              } else if (state.reviews.isEmpty) {
                                return EmptyReviewWidget(
                                  message:
                                      "Be the first to review this product",
                                );
                              } else if (state.filterReviews.isEmpty) {
                                return EmptyReviewWidget(
                                  message:
                                      "There are no reviews with ${state.stars.index}-Stars",
                                );
                              }
                              return ListView.separated(
                                padding: EdgeInsets.only(
                                  top: 20.h,
                                  bottom: 80.h,
                                ),
                                itemBuilder: (context, index) {
                                  return ReviewWidget(
                                    review: state.filterReviews[index],
                                  );
                                },
                                separatorBuilder:
                                    (context, index) => 20.verticalSpace,
                                itemCount: state.filterReviews.length,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  InkWell _iconBtn(String svg, String text, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFFE5E5E5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.sp12(text).w400.setColor(const Color(0xFFBDC4CD)),
            3.horizontalSpace,
            SvgPicture.asset(
              svg,
              height: 16.r,
              colorFilter: const ColorFilter.mode(
                Color(0xFFBDC4CD),
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
