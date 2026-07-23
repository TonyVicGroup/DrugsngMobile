import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/lab_test/domain/models/diagnostic_test.dart';
import 'package:drugs_ng/features/lab_test/presentation/cubit/lab_test_cubit.dart';
import 'package:drugs_ng/features/lab_test/presentation/widgets/diagnostic_test_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DiagnosticListWidget extends StatelessWidget {
  final LabTestState state;

  const DiagnosticListWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 255.h,
      child: Builder(
        builder: (context) {
          if (state.diagnosticStatus.isLoading) {
            return Shimmer.fromColors(
              baseColor: AppColor.shimmerBase,
              highlightColor: AppColor.shimmerHighlight,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => _container(225.h, 192.w, 10.r),
                separatorBuilder: (context, index) => 15.horizontalSpace,
                itemCount: 4,
              ),
            );
          } else if (state.diagnosticStatus.isSuccess) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                DiagnosticTest test = state.diagnosticTests[index];
                return DiagnosticTestWidget(test: test);
              },
              separatorBuilder: (context, index) => 15.horizontalSpace,
              itemCount: state.diagnosticTests.length,
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
