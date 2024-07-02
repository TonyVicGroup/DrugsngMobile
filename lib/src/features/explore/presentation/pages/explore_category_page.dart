import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/explore/presentation/widgets/category_filter_widget.dart';
import 'package:drugs_ng/src/features/explore/presentation/widgets/explore_grid_tile.dart';
import 'package:drugs_ng/src/features/explore/presentation/widgets/explore_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreCategoryPage extends StatelessWidget {
  const ExploreCategoryPage({super.key});

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
        title: AppText.sp18("General Health").w700.black,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: search,
            child: Padding(
              padding: EdgeInsets.all(10.r),
              child: SizedBox(
                width: 24.r,
                height: 24.r,
                child: SvgPicture.asset(AppSvg.search),
              ),
            ),
          ),
          10.horizontalSpace,
        ],
        bottom: PreferredSize(
          preferredSize: Size(double.maxFinite, 100.h),
          child: SizedBox(
            height: 100.h,
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Row(
                    children: [
                      _allergy(),
                      const Spacer(),
                      _filterButton(),
                      const Spacer(),
                      _newArrival(),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 2.h,
                        ),
                        child: SvgPicture.asset(
                          AppSvg.grid,
                          width: 17.w,
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 28.h,
                  width: double.maxFinite,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 15.w),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoryFilterWidget(text: "text", onTap: () {});
                    },
                    separatorBuilder: (context, index) => 15.horizontalSpace,
                    itemCount: 7,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        itemBuilder: (context, index) {
          return ExploreListTile(
            img: AppImage.molfix,
            rating: 4,
            totalRating: 23,
            category: "Alle",
            name: "Another name",
            price: 30,
            prevPrice: 100,
            percentReduction: 10,
          );
        },
        separatorBuilder: (context, index) => 25.verticalSpace,
        itemCount: 12,
      ),
    );
  }

  GridView _appBody() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.71,
        crossAxisSpacing: 18.w,
        mainAxisSpacing: 25.h,
      ),
      itemBuilder: (context, index) {
        return ExploreGridTile(
          img: AppImage.molfix,
          rating: 4,
          totalRating: 23,
          category: "Alle",
          name: "Another name",
          price: 30,
          prevPrice: 100,
          percentReduction: 10,
        );
      },
    );
  }

  InkWell _filterButton() {
    return InkWell(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppSvg.filters,
            height: 12.h,
            width: 18.w,
          ),
          8.horizontalSpace,
          AppText.sp14("Filters").w400.black,
        ],
      ),
    );
  }

  InkWell _newArrival() {
    return InkWell(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppSvg.sortBy,
            height: 18.h,
            width: 14.w,
          ),
          8.horizontalSpace,
          AppText.sp14("New arrival").w400.black,
        ],
      ),
    );
  }

  InkWell _allergy() {
    return InkWell(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.sp14("Allergy").w400.black,
          8.horizontalSpace,
          RotatedBox(
            quarterTurns: 3,
            child: SvgPicture.asset(
              AppSvg.chevronThick,
              height: 15.w,
              width: 14.w,
            ),
          ),
        ],
      ),
    );
  }

  void search() {}
}
