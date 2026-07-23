import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/rating_filter_enum.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/empty_review_widget.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/product/presentation/widgets/modify_review_widget.dart';
import 'package:drugs_ng/features/product/presentation/widgets/product_review_loader.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/reviews_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MyReviewPage extends StatefulWidget {
  const MyReviewPage({super.key});

  @override
  State<MyReviewPage> createState() => _MyReviewPageState();
}

class _MyReviewPageState extends State<MyReviewPage> {
  @override
  void initState() {
    super.initState();
    if (context.read<ReviewsCubit>().state.status.isInitial) {
      context.read<ReviewsCubit>().getReviews(
        context.read<AuthCubit>().state.user!.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewsCubit, ReviewsState>(
      listener: (context, state) {},
      builder: (context, state) {
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
            title: AppText.sp18("My Review").w700.black,
            centerTitle: true,
            actions: [
              if (!state.status.isLoading)
                IconButton(
                  onPressed: () {
                    context.read<ReviewsCubit>().getReviews(
                      context.read<AuthCubit>().state.user!.id,
                    );
                  },
                  icon: const Icon(Icons.refresh),
                ),
            ],
          ),
          body: Padding(
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
                        border: Border.all(color: const Color(0xFFE5E5E5)),
                      ),
                      child: DropdownButton<RatingFilterEnum>(
                        value: state.filter,
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
                                    ).w400.setColor(const Color(0xFF8B96A5)),
                                  ),
                                )
                                .toList(),
                        onChanged: (v) {
                          if (v != null) {
                            context.read<ReviewsCubit>().filter(v);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (state.status.isLoading) {
                        return const ProductReviewLoader();
                      } else if (state.reviews.isEmpty) {
                        return EmptyReviewWidget(
                          message: "You have not written any reviews yet",
                        );
                      } else if (state.filteredReviews.isEmpty) {
                        return EmptyReviewWidget(
                          message:
                              "You have no reviews with ${state.filter.index}-Stars",
                        );
                      }
                      return ListView.separated(
                        padding: EdgeInsets.only(top: 20.h, bottom: 80.h),
                        itemBuilder: (context, index) {
                          return ModifyReviewWidget(
                            review: state.filteredReviews[index],
                          );
                        },
                        separatorBuilder: (context, index) => 20.verticalSpace,
                        itemCount: state.filteredReviews.length,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
