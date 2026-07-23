import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/home/presentation/widgets/home_carousel_widget.dart';
import 'package:drugs_ng/features/lab_test/presentation/cubit/lab_test_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LabTestCarousel extends StatelessWidget {
  final LabTestState state;

  const LabTestCarousel({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.adStatus.isLoading) {
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
            ],
          ),
        ),
      );
    } else if (state.adStatus.isSuccess) {
      return HomeCarouselWidget(ads: state.ads);
    } else {
      return AppText.sp16("Some error occured");
    }
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
