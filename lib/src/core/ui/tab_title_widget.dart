import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabTitleWidget extends StatelessWidget {
  final bool isTab1;
  final String title1;
  final String title2;
  final double overallWidth;
  final double width1;
  final double width2;
  final Duration animationDuration;
  final void Function(bool) onChanged;
  const TabTitleWidget({
    super.key,
    required this.title1,
    required this.title2,
    required this.overallWidth,
    required this.width1,
    this.animationDuration = const Duration(milliseconds: 200),
    required this.width2,
    required this.isTab1,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: overallWidth,
      height: 36.h,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.r),
        color: const Color(0xFFF7F9FB),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: animationDuration,
            alignment: Alignment(isTab1 ? -1 : 1, 0),
            child: AnimatedContainer(
              duration: animationDuration,
              width: isTab1 ? width1 : width2,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
                color: AppColor.primary,
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    onChanged(true);
                  },
                  child: _text(title1, isTab1),
                ),
                InkWell(
                  onTap: () {
                    onChanged(false);
                  },
                  child: _text(title2, !isTab1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _text(String txt, bool active) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: 14.sp,
        color: active ? AppColor.white : AppColor.primary,
        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
        fontFamily: AppText.fontFamily,
      ),
    );
  }
}
