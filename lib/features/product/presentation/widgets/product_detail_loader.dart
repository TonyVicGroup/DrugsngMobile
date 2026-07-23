import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailLoader extends StatelessWidget {
  const ProductDetailLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmerBase,
      highlightColor: AppColor.shimmerHighlight,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _container(300.h, double.maxFinite, 0),
            20.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _container(18.h, 40.w, 0),
                  5.verticalSpace,
                  _container(19.h, double.maxFinite, 0),
                  _container(19.h, 150.w, 0),
                  20.verticalSpace,
                  _container(18.h, 300.w, 0),
                  20.verticalSpace,
                  _container(70.h, double.maxFinite, 0),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _container(20.h, 40.w, 2.r),
                      _container(20.h, 240.w, 2.r),
                    ],
                  ),
                  20.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _container(20.h, 60.w, 2.r),
                      _container(102.h, 240.w, 2.r),
                    ],
                  ),
                  20.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _container(20.h, 60.w, 2.r),
                      _container(102.h, 240.w, 2.r),
                    ],
                  ),
                  20.verticalSpace,
                ],
              ),
            ),
            SizedBox(
              height: 263.h,
              child: ListView.separated(
                padding: EdgeInsets.only(left: 16.w),
                scrollDirection: Axis.horizontal,
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
