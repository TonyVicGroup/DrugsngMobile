import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifiedFailedWidget extends StatelessWidget {
  const VerifiedFailedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColor.colorFFFFFF),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 88.r,
            height: 88.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.color0B8AE1.withAlpha(25),
            ),
          ),
        ],
      ),
    );
  }
}
