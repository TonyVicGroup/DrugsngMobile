import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class RecentUploadLoader extends StatelessWidget {
  const RecentUploadLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Shimmer.fromColors(
        baseColor: AppColor.shimmerBase,
        highlightColor: AppColor.shimmerHighlight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            16.verticalSpace,
            _recents(),
            16.verticalSpace,
            _recents(),
            16.verticalSpace,
            _recents(),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }

  Row _recents() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _container(25.r, 25.r, 0),
        12.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _container(16.h, 225.w, 0),
            5.verticalSpace,
            _container(14.h, 35.w, 0),
          ],
        ),
        const Spacer(),
        _container(20.h, 57.w, 2.r),
      ],
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
