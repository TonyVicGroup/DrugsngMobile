import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/enum/rating_enum.dart';
import 'package:drugs_ng/src/core/ui/app_checkbox.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/explore/presentation/bloc/explore_filter/explore_filter_bloc.dart';
import 'package:drugs_ng/src/features/explore/presentation/pages/explore_brand_name_page.dart';
import 'package:drugs_ng/src/features/explore/presentation/pages/explore_subcategory_page.dart';
import 'package:drugs_ng/src/features/explore/presentation/widgets/explore_bottons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:expandable/expandable.dart';

class ExploreFiltersPage extends StatefulWidget {
  const ExploreFiltersPage({super.key});

  @override
  State<ExploreFiltersPage> createState() => _ExploreFiltersPageState();
}

class _ExploreFiltersPageState extends State<ExploreFiltersPage> {
  final double maxValue = 500;
  final double minValue = 0;
  late int startRange;
  late int endRange;
  late RatingEnum ratingEnum;
  late Set<String> brands;
  String? subcategory;

  late ExpandableController priceRangeCntrl;
  late ExpandableController ratingCntrl;

  late TextEditingController minCntrl;
  late TextEditingController maxCntrl;

  @override
  void initState() {
    super.initState();
    priceRangeCntrl = ExpandableController(initialExpanded: true);
    ratingCntrl = ExpandableController(initialExpanded: true);

    reset();
  }

  @override
  void dispose() {
    priceRangeCntrl.dispose();
    ratingCntrl.dispose();
    maxCntrl.dispose();
    minCntrl.dispose();
    super.dispose();
  }

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
      body: BlocBuilder<ExploreFilterBloc, ExploreFilterState>(
        builder: (context, state) {
          return Column(
            children: [
              20.verticalSpace,
              _listTile(
                "Subcategory",
                subcategory ?? "",
                _chooseSubcategory,
              ),
              10.verticalSpace,
              _listTile(
                "Brand Name",
                brands.join(', '),
                _chooseBrandName,
              ),
              10.verticalSpace,
              _listTile("Generic Name", "Food allergy", () {}),
              10.verticalSpace,
              ExpandablePanel(
                controller: priceRangeCntrl,
                header: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
                  child: AppText.sp16("Price Range").w700.black,
                ),
                expanded: sliderWidget(),
                collapsed: const SizedBox.shrink(),
              ),
              10.verticalSpace,
              ExpandablePanel(
                controller: ratingCntrl,
                header: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
                  child: AppText.sp16("Rating").w700.black,
                ),
                expanded: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      15.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.sp16("All Star").w400.black,
                          AppCheckbox.primary(
                            value: ratingEnum == RatingEnum.all,
                            onChanged: (v) {
                              setState(() {
                                ratingEnum = RatingEnum.all;
                              });
                            },
                          ),
                        ],
                      ),
                      15.verticalSpace,
                      _starRow(5, RatingEnum.five),
                      15.verticalSpace,
                      _starRow(4, RatingEnum.four),
                      15.verticalSpace,
                      _starRow(3, RatingEnum.three),
                      15.verticalSpace,
                      _starRow(2, RatingEnum.two),
                      15.verticalSpace,
                      _starRow(1, RatingEnum.one),
                    ],
                  ),
                ),
                collapsed: const SizedBox.shrink(),
              ),
              35.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DiscardButton(onTap: _discard),
                    ApplyButton(onTap: _save),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget sliderWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SliderTheme(
            data: SliderThemeData(
              rangeThumbShape:
                  RoundRangeSliderThumbShape(enabledThumbRadius: 10.r),
              overlayShape: SliderComponentShape.noThumb,
              trackHeight: 4.w,
              rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
            ),
            child: RangeSlider(
              activeColor: AppColor.primary,
              inactiveColor: AppColor.lightBlue,
              min: minValue,
              max: maxValue,
              values: RangeValues(
                startRange.toDouble(),
                endRange.toDouble(),
              ),
              onChanged: (newValues) {
                startRange = newValues.start.round();
                endRange = newValues.end.round();
                maxCntrl.text = endRange.toString();
                minCntrl.text = startRange.toString();
                setState(() {});
              },
            ),
          ),
        ),
        10.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rangeEnd("Min", false, minCntrl),
              _rangeEnd("Max", true, maxCntrl),
            ],
          ),
        )
      ],
    );
  }

  SizedBox _rangeEnd(String title, bool isMax, TextEditingController cntrl) {
    return SizedBox(
      width: 120.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.sp16(title).w400.setColor(
                AppColor.black.withOpacity(0.7),
              ),
          4.verticalSpace,
          Theme(
            data: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                constraints: BoxConstraints(maxWidth: 120.w, maxHeight: 44.h),
              ),
            ),
            child: TextField(
              cursorHeight: 30.h,
              controller: cntrl,
              enabled: false,
              cursorColor: AppColor.lightGrey,
              keyboardType: TextInputType.number,
              onChanged: (v) {
                double value = double.tryParse(v) ?? 0;
                if (isMax) {
                  if (value > startRange) {
                    endRange = value.round();
                  }
                } else {
                  if (value < endRange) {
                    startRange = value.round();
                  }
                }
                setState(() {});
              },
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFBDC4CD),
                height: 1,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: const BorderSide(color: AppColor.lightGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: const BorderSide(color: AppColor.lightGrey),
                ),
              ),
            ),
          )
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

  Widget _starRow(int value, RatingEnum rating) {
    int filled = rating.starCount;
    int unfilled = 5 - rating.starCount;
    return Row(
      children: [
        ...List.generate(filled, (idx) {
          return Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: SvgPicture.asset(
              AppSvg.starFilled,
              colorFilter:
                  const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
            ),
          );
        }),
        ...List.generate(unfilled, (idx) {
          return Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: SvgPicture.asset(
              AppSvg.starFilled,
              colorFilter:
                  const ColorFilter.mode(AppColor.lightGrey, BlendMode.srcIn),
            ),
          );
        }),
        const Spacer(),
        AppCheckbox.primary(
            value: rating == ratingEnum,
            onChanged: (v) {
              setState(() {
                ratingEnum = rating;
              });
            }),
      ],
    );
  }

  void reset() {
    final state = context.read<ExploreFilterBloc>().state;
    minCntrl = TextEditingController(text: state.minPriceRange.toString());
    maxCntrl = TextEditingController(text: state.maxPriceRange.toString());
    startRange = state.minPriceRange;
    endRange = state.maxPriceRange;
    ratingEnum = state.ratingEnum;
    brands = state.brandName;
    subcategory = state.subcategory;
  }

  Future _chooseBrandName() async {
    brands = await Navigator.push<Set<String>?>(
          context,
          AppUtils.transition(
            ExploreBrandNamePage(brandNames: brands),
          ),
        ) ??
        brands;
    setState(() {});
  }

  Future _chooseSubcategory() async {
    subcategory = await Navigator.push<String?>(
            context,
            AppUtils.transition(
              ExploreSubcategoryPage(subcategory: subcategory),
            )) ??
        subcategory;
    setState(() {});
  }

  void _discard() {
    reset();
  }

  void _save() {
    context.read<ExploreFilterBloc>().add(
          UpdateExploreFilter(
            brandNames: brands,
            subcategory: subcategory,
            rating: ratingEnum,
            minPriceRange: startRange,
            maxPriceRange: endRange,
          ),
        );
    Navigator.pop(context);
  }
}
