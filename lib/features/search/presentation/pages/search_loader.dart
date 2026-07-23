import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SearchLoader extends StatelessWidget {
  final int length;

  const SearchLoader({super.key, required this.length});

  @override
  Widget build(BuildContext context) {
    // if length is empty show list of
    int listLength = length <= 0 ? 3 : length;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Shimmer.fromColors(
        baseColor: AppColor.shimmerBase,
        highlightColor: AppColor.shimmerHighlight,
        child: ListView.separated(
          itemBuilder:
              (context, index) => _container(105.h, double.maxFinite, 5.r),
          separatorBuilder: (context, index) => 20.verticalSpace,
          itemCount: listLength,
        ),
      ),
    );
  }

  Container _container(double height, double width, double radius) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColor.shimmerHighlight,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
