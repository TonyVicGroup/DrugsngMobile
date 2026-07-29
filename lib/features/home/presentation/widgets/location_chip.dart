import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/home/presentation/cubit/get_country_cubit.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LocationChip extends StatelessWidget {
  const LocationChip._();

  static Widget widget(BuildContext context) {
    return BlocProvider(
      create: (context) => GetCountryCubit()..fetchCountry(),
      child: const LocationChip._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (context.read<GetCountryCubit>().state.status.isInitial) {
      context.read<GetCountryCubit>().fetchCountry();
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
