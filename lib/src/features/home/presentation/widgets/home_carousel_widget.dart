import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCarouselWidget extends StatelessWidget {
  const HomeCarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return FlutterCarousel(
          options: CarouselOptions(
            height: 172.h,
            viewportFraction: 1,
            showIndicator: true,
            floatingIndicator: false,
            slideIndicator: CircularSlideIndicator(
              indicatorRadius: 2.5.r,
              indicatorBackgroundColor: const Color(0xFFBDC4CD),
              currentIndicatorColor: AppColor.primary,
              itemSpacing: (state.data.homeAds.length + 2).r,
            ),
            autoPlay: true,
            enableInfiniteScroll: true,
          ),
          items: state.data.homeAds.map((ad) {
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
                            ad.imageUrl,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText.sp14(ad.title).w500.white,
                                      const Spacer(),
                                      AppText.sp12(ad.subtitle)
                                          .w400
                                          .whiteBlue
                                          .setMaxLines(2)
                                          .setLineHeight(1),
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
                                  child: AppText.sp14("Book Now")
                                      .w500
                                      .primaryColor,
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
      },
    );
  }
}
