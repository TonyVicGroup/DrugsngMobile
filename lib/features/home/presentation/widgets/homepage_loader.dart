import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomepageLoader extends StatelessWidget {
  const HomepageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Shimmer.fromColors(
        baseColor: AppColor.shimmerBase,
        highlightColor: AppColor.shimmerHighlight,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _container(155.sp, double.maxFinite, 10.r),
            10.verticalSpace,
            _container(10.h, 40.w, 10.r),
            30.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _container(20.h, 100.w, 2.r),
                _container(20.h, 40.w, 2.r),
              ],
            ),
            12.verticalSpace,
            SizedBox(
              height: 263.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder:
                    (context, index) => SizedBox(
                      width: 148.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _container(184.h, 148.w, 5.r),
                          _container(14.h, 95.w, 0),
                          _container(11.h, 33.w, 0),
                          _container(14.h, 98.w, 0),
                          // _container(14.h, 98.w, 0),
                          _container(14.h, 78.w, 0),
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) => 15.horizontalSpace,
                itemCount: 3,
              ),
            ),
            30.verticalSpace,
            _container(156.h, double.maxFinite, 5.r),
            30.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _container(20.h, 100.w, 2.r),
                _container(20.h, 40.w, 2.r),
              ],
            ),
            12.verticalSpace,
            SizedBox(
              height: 263.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder:
                    (context, index) => SizedBox(
                      width: 148.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _container(184.h, 148.w, 5.r),
                          _container(14.h, 95.w, 0),
                          _container(11.h, 33.w, 0),
                          _container(14.h, 98.w, 0),
                          // _container(14.h, 98.w, 0),
                          _container(14.h, 78.w, 0),
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) => 15.horizontalSpace,
                itemCount: 3,
              ),
            ),
          ],
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
