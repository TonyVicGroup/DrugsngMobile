import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class EmptyReviewWidget extends StatelessWidget {
  final String message;
  const EmptyReviewWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Row(),
          SvgPicture.asset(
            AppSvg.addReview,
            height: 80.r,
            colorFilter: const ColorFilter.mode(
              Color(0xFFE5E5E5),
              BlendMode.srcIn,
            ),
          ),
          24.verticalSpace,
          AppText.sp18("No reviews yet").w600.black,
          8.verticalSpace,
          AppText.sp14(message).w400.setColor(const Color(0xFF8B96A5)),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
