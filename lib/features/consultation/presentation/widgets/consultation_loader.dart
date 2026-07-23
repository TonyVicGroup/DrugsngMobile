import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ConsultationLoader extends StatelessWidget {
  const ConsultationLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Shimmer.fromColors(
        baseColor: AppColor.shimmerBase,
        highlightColor: AppColor.shimmerHighlight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _container(192.h, double.maxFinite, 5.r),
            30.verticalSpace,
            _container(20.h, 70.w, 5.r),
            20.verticalSpace,
            SizedBox(
              height: 63.h,
              width: double.maxFinite,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _container(40.r, 40.r, 20.r),
                      _container(14.r, 60.r, 0),
                    ],
                  );
                },
                separatorBuilder: (context, index) => 25.horizontalSpace,
                itemCount: 7,
              ),
            ),
            30.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _container(20.h, 140.w, 5.r),
                _container(20.h, 40.w, 5.r),
              ],
            ),
            20.verticalSpace,
            _container(101.h, double.maxFinite, 10.r),
            20.verticalSpace,
            _container(101.h, double.maxFinite, 10.r),
            20.verticalSpace,
            _container(101.h, double.maxFinite, 10.r),
            30.verticalSpace,
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
