import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppRangeSlider extends StatefulWidget {
  const AppRangeSlider({super.key});

  @override
  State<AppRangeSlider> createState() => _AppRangeSliderState();
}

class _AppRangeSliderState extends State<AppRangeSlider> {
  double position1 = 0;
  double position2 = 1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: double.maxFinite,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 6,
            child: Container(
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFAFD0FF),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          Align(
            child: Container(
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFAFD0FF),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          trackMin(),
          trackMax(),
        ],
      ),
    );
  }

  Align trackMin() {
    return Align(
      alignment: Alignment(position1, 0),
      child: _thumb(),
    );
  }

  Align trackMax() {
    return Align(
      alignment: Alignment(position2, 0),
      child: _thumb(),
    );
  }

  Container _thumb() {
    return Container(
      width: 20.h,
      height: 20.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFAFD0FF)),
        color: Colors.white,
      ),
    );
  }
}
