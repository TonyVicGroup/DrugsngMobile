import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/navigation/app_route.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/cart_icon_button.dart';
import 'package:drugs_ng/core/widgets/buttons/notification_icon_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/textfield/border_text_field.dart';
import 'package:drugs_ng/features/home/presentation/cubit/get_country_cubit.dart';
import 'package:drugs_ng/features/search/data/models/search_item.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 65.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColor.colorFFFFFF,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Row(
            children: [
              _LocationChip(),
              const Spacer(),
              CustomImage(Assets.images.drugs.path, width: 35.w),
              5.horizontalSpace,
              AppText.sp14('DrugsNG').w400.setColor(AppColor.color0B8AE1),
              const Spacer(),
              CartIconButton(),
              10.horizontalSpace,
              NotificationIconButton(),
            ],
          ),
        ),

        10.verticalSpace,
        BorderTextField(
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
          onTap:
              onTap ??
              () {
                context.pushNamed(
                  AppRoutes.searchPage,
                  arguments: SearchType.product,
                );
              },
        ),
      ],
    );
  }
}

class _LocationChip extends StatelessWidget {
  const _LocationChip();

  @override
  Widget build(BuildContext context) {
    if (context.read<GetCountryCubit>().state.status.isInitial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<GetCountryCubit>().fetchCountry();
      });
    }
    return BlocBuilder<GetCountryCubit, GetCountryState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return Shimmer.fromColors(
            baseColor: AppColor.shimmerBase,
            highlightColor: AppColor.shimmerHighlight,
            child: Container(
              height: 38.h,
              width: 116.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColor.white,
              ),
            ),
          );
        }

        return InkWell(
          onTap:
              state.status.isFailed
                  ? () {
                    context.read<GetCountryCubit>().fetchCountry();
                  }
                  : null,
          child: Container(
            height: 38.h,
            constraints: BoxConstraints(maxWidth: 116.w),
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColor.colorDBE2EA,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImage(
                  Assets.svg.locationFilled,
                  width: 16.w,
                  height: 16.h,
                  color: AppColor.color333333,
                ),
                8.horizontalSpace,
                AppText.sp14(
                  state.country,
                ).w500.black.setMaxLines(1).setColor(AppColor.color333333),
              ],
            ),
          ),
        );
      },
    );
  }
}
