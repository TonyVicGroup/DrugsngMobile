import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ExploreCategoryLoader extends StatelessWidget {
  const ExploreCategoryLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Shimmer.fromColors(
        baseColor: AppColor.shimmerBase,
        highlightColor: AppColor.shimmerHighlight,
        child: GridView.builder(
          itemCount: 3,
          padding: EdgeInsets.only(top: 20.h),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.71,
            crossAxisSpacing: 18.w,
            mainAxisSpacing: 25.h,
          ),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _container(184.h, 190.w, 5.r),
                _container(18.h, 150.w, 0),
                _container(18.h, 33.w, 0),
                _container(18.h, 128.w, 0),
                // _container(14.h, 98.w, 0),
                _container(18.h, 78.w, 0),
              ],
            );
          },
        ),
        // child: Column(
        //   mainAxisSize: MainAxisSize.max,
        //   children: [
        //     SizedBox(
        //       height: 263.h,
        //       child: ListView.separated(
        //         scrollDirection: Axis.horizontal,
        //         itemBuilder: (context, index) => SizedBox(
        //           width: 148.w,
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               _container(184.h, 148.w, 5.r),
        //               _container(14.h, 95.w, 0),
        //               _container(11.h, 33.w, 0),
        //               _container(14.h, 98.w, 0),
        //               // _container(14.h, 98.w, 0),
        //               _container(14.h, 78.w, 0),
        //             ],
        //           ),
        //         ),
        //         separatorBuilder: (context, index) => 15.horizontalSpace,
        //         itemCount: 3,
        //       ),
        //     ),
        //   ],
        // ),
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
