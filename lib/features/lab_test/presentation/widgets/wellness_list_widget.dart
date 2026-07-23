import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/lab_test/domain/models/wellness_package.dart';
import 'package:drugs_ng/features/lab_test/presentation/cubit/lab_test_cubit.dart';
import 'package:drugs_ng/features/lab_test/presentation/widgets/wellness_package_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class WellnessListWidget extends StatelessWidget {
  final LabTestState state;
  const WellnessListWidget(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 225.h,
      child: Builder(
        builder: (context) {
          if (state.wellnessStatus.isLoading) {
            return Shimmer.fromColors(
              baseColor: AppColor.shimmerBase,
              highlightColor: AppColor.shimmerHighlight,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => _container(162.h, 295.w, 10.r),
                separatorBuilder: (context, index) => 16.horizontalSpace,
                itemCount: 4,
              ),
            );
          } else if (state.wellnessStatus.isSuccess) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                WellnessPackage package = state.wellnessPackages[index];
                return WellnessPackageWidget(package: package, width: 295.w);
              },
              separatorBuilder: (context, index) => 16.horizontalSpace,
              itemCount: state.wellnessPackages.length,
            );
          } else {
            return Center(child: AppText.sp14("Something went wrong"));
          }
        },
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
