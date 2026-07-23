import 'dart:math' as math;
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PullRefreshLoader extends StatelessWidget {
  final IndicatorController controller;

  const PullRefreshLoader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.r),
      child: CircularProgressIndicator(
        color: AppColor.primary,
        strokeCap: StrokeCap.round,
        value:
            controller.state.isLoading ? null : math.min(controller.value, 1.0),
      ),
    );
  }
}
