import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/ui/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCarouselWidget extends StatelessWidget {
  const HomeCarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: CarouselOptions(
        height: 171.h,
        viewportFraction: 1,
        showIndicator: true,
        floatingIndicator: false,
        slideIndicator: CircularSlideIndicator(
          indicatorRadius: 2.5.r,
          indicatorBackgroundColor: const Color(0xFFBDC4CD),
          currentIndicatorColor: AppColor.primary,
          itemSpacing: 6.r,
        ),
        autoPlay: true,
        enableInfiniteScroll: true,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Image.asset(
                        AppImage.homeAd,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 70.h,
                      child: Container(
                        color: AppColor.primary,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText.sp14("Dental health").w500.white,
                                  const Spacer(),
                                  AppText.sp12(
                                          "Access complete oral care at 30% discounted rate.")
                                      .w400
                                      .whiteBlue
                                      .setMaxLines(2),
                                ],
                              ),
                            ),
                            10.horizontalSpace,
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 17.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.r),
                                color: const Color(0xFFEDF8FF),
                              ),
                              child: AppText.sp14("Book Now").w500.primaryColor,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
