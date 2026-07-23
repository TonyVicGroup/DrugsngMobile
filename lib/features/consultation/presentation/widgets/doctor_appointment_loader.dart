import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DoctorAppointmentLoader extends StatelessWidget {
  const DoctorAppointmentLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Shimmer.fromColors(
          baseColor: AppColor.shimmerBase,
          highlightColor: AppColor.shimmerHighlight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              30.verticalSpace,
              _container(329.h, 358.w, 10.r),
              30.verticalSpace,
              _container(82.h, double.maxFinite, 6.r),
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_container(20.h, 80.w, 5.r)],
              ),
              10.verticalSpace,
              _container(60.h, double.maxFinite, 5.r),
              30.verticalSpace,
              Row(children: [_container(20.h, 80.w, 5.r)]),
              10.verticalSpace,
              Row(
                children: [
                  _container(41.h, 82.w, 6.r),
                  20.horizontalSpace,
                  _container(41.h, 82.w, 6.r),
                ],
              ),
              30.verticalSpace,
              _container(60.h, double.maxFinite, 5.r),
              30.verticalSpace,
            ],
          ),
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
