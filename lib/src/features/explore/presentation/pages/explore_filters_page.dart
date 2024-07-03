import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/features/explore/presentation/widgets/app_range_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreFiltersPage extends StatelessWidget {
  const ExploreFiltersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 5,
        surfaceTintColor: AppColor.white,
        backgroundColor: AppColor.white,
        leading: Center(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              width: 20.r,
              height: 20.r,
              child: SvgPicture.asset(AppSvg.chevronThick),
            ),
          ),
        ),
        title: AppText.sp18("Filters").w700.black,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          20.verticalSpace,
          _listTile("Subcategory", "Food allergy", () {}),
          10.verticalSpace,
          _listTile("Brand Name", "Food allergy", () {}),
          10.verticalSpace,
          _listTile("Generic Name", "Food allergy", () {}),
          10.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AppRangeSlider(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 3.w),
            child: SliderTheme(
              data: SliderThemeData(
                rangeThumbShape:
                    RoundRangeSliderThumbShape(enabledThumbRadius: 3.w),
                overlayShape: SliderComponentShape.noThumb,
                trackHeight: 4.w,
                rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
              ),
              child: RangeSlider(
                  activeColor: AppColor.primary,
                  inactiveColor: AppColor.lightBlue,
                  min: 0,
                  max: 10,
                  values: RangeValues(2, 5),
                  onChanged: (newValues) {
                    // setState(() {
                    //   minSliderRange =
                    //       newValues.start.toInt();
                    //   maxSliderRange =
                    //       newValues.end.toInt();
                    // });
                    // cntr.updateMinSliderPrice(newValues.start.round());
                    // cntr.updateMaxSliderPrice(newValues.end.round());
                  }),
            ),
          ),
        ],
      ),
    );
  }

  InkWell _listTile(String title, String subtitle, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.sp16(title).w700.black,
                  AppText.sp12(subtitle).w400.lightGrey,
                ],
              ),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: SvgPicture.asset(
                AppSvg.chevronThick,
                height: 16.h,
                colorFilter:
                    const ColorFilter.mode(AppColor.darkGrey, BlendMode.srcIn),
              ),
            )
          ],
        ),
      ),
    );
  }
}
