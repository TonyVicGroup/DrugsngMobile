import 'dart:math';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabDashboardProgressTile extends StatelessWidget {
  const LabDashboardProgressTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [setupTile(), setupTile()]),
    );
  }

  Widget setupTile() {
    return Container(
      margin: EdgeInsets.only(left: 16.r),
      width: 374.w,
      padding: EdgeInsets.fromLTRB(7.w, 10.h, 12.w, 10.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.black.withOpacity(0.09)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          const CircularArcWidget(value: 25, text: '1/4'),
          10.horizontalSpace,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.sp14('Account Setup').w600.primaryColor,
                AppText.sp12(
                  'Finish setting up your account as some features might be restricted',
                ).w500.subTextLight,
              ],
            ),
          ),
          10.horizontalSpace,
          Container(
            width: 40.r,
            height: 40.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.r),
              color: AppColor.primaryLight,
            ),
            child: CustomImage(
              AppSvg.setting,
              width: 18.r,
              height: 18.r,
              color: AppColor.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class CircularArcWidget extends StatelessWidget {
  final double value; // Value between 0 and 100
  final String text;

  const CircularArcWidget({super.key, required this.value, required this.text})
    : assert(value >= 0 && value <= 100, 'Value must be between 0 and 100');

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(43.r, 43.r), // Fixed size for the arc
      painter: ArcPainter(value),
      child: Container(
        width: 43.r,
        height: 43.r,
        alignment: Alignment.center,
        child: AppText.sp14(text).primaryColor,
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  final double value;

  ArcPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    final Paint backgroundPaint =
        Paint()
          ..color = const Color(0x66D9D9D9)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4.0;

    final Paint paint =
        Paint()
          ..color = AppColor.primary
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4.0
          ..strokeCap = StrokeCap.round;

    double startAngle = -pi / 2; // Start from the top center
    double sweepAngle = (value / 100) * 2 * pi; // Convert percentage to radians

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      2 * pi,
      false,
      backgroundPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
