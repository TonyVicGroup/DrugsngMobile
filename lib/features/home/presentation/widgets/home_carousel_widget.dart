import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/home/domain/models/home_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCarouselWidget extends StatelessWidget {
  final List<HomeAds> ads;
  const HomeCarouselWidget({super.key, required this.ads});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: FlutterCarouselOptions(
        height: 172.sp,
        viewportFraction: 1,
        showIndicator: true,
        floatingIndicator: false,
        slideIndicator: CircularSlideIndicator(
          slideIndicatorOptions: SlideIndicatorOptions(
            indicatorRadius: 2.5,
            indicatorBackgroundColor: const Color(0xFFBDC4CD),
            currentIndicatorColor: AppColor.primary,
            itemSpacing: ads.length * 4.w,
          ),
        ),
        autoPlay: true,
        enableInfiniteScroll: true,
      ),
      items:
          ads.map((ad) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(ad.imageUrl, fit: BoxFit.cover),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: 75.sp,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      AppText.sp14(ad.title).w500.white,
                                      AppText.sp20("Coming Soon").w700.white,

                                      // AppText.sp12(ad.subtitle).w400.whiteBlue
                                      //     .setMaxLines(2)
                                      //     .setLineHeight(1.2),
                                    ],
                                  ),
                                ),
                                // 10.horizontalSpace,
                                // Container(
                                //   padding: EdgeInsets.symmetric(
                                //     horizontal: 17.w,
                                //     vertical: 12.h,
                                //   ),
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(50.r),
                                //     color: const Color(0xFFEDF8FF),
                                //   ),
                                //   child:
                                //       AppText.sp14(
                                //         "Book Now",
                                //       ).w500.primaryColor,
                                // ),
                              ],
                            ),
                          ),
                        ),
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
