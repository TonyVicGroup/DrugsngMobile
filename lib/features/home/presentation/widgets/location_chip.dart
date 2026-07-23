import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/home/presentation/cubit/get_country_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              height: 30.sp,
              width: 90.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.r),
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
            height: 30.sp,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.r),
              color: const Color(0xFFEAEFF5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppSvg.location,
                  colorFilter: const ColorFilter.mode(
                    AppColor.black,
                    BlendMode.srcIn,
                  ),
                ),
                8.horizontalSpace,
                AppText.sp14(state.country).w300.black.setMaxLines(1),
              ],
            ),
          ),
        );
      },
    );
  }
}
