import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductReviewLoader extends StatelessWidget {
  const ProductReviewLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmerBase,
      highlightColor: AppColor.shimmerHighlight,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            20.verticalSpace,
            _reviewWidget(),
            20.verticalSpace,
            _reviewWidget(),
          ],
        ),
      ),
    );
  }

  Container _reviewWidget() {
    return Container(
      width: double.maxFinite,
      height: 311.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.shimmerHighlight, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_container(80.r, 80.r, 0), _container(24.h, 136.w, 0)],
          ),
          _container(19.h, 123.w, 0),
          _container(80.h, double.maxFinite, 0),
          _container(14.h, 143.w, 0),
          Row(
            children: [
              _container(32.h, 82.w, 10.r),
              10.horizontalSpace,
              _container(32.h, 82.w, 10.r),
              const Spacer(),
              _container(20.r, 20.r, 0),
            ],
          ),
        ],
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
