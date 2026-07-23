import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/rating_enum.dart';
import 'package:drugs_ng/core/widgets/app_radio.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_formater.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/explore/domain/models/explore_filter.dart';
import 'package:drugs_ng/features/explore/domain/models/generic_brand_name.dart';
import 'package:drugs_ng/features/explore/domain/models/major_category.dart';
import 'package:drugs_ng/features/explore/domain/models/sub_category.dart';
import 'package:drugs_ng/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:drugs_ng/features/explore/presentation/cubit/explore_names_cubit.dart';
import 'package:drugs_ng/features/explore/presentation/pages/explore_brand_name_page.dart';
import 'package:drugs_ng/features/explore/presentation/pages/explore_subcategory_page.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/explore_bottons.dart';
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
  final int maxValue = 500000, minValue = 0;
  late double startRange, endRange;
  late RatingEnum ratingEnum;
  late Set<GenericBrandName> brands;
  late Set<GenericBrandName> genericNames;
  SubCategory? subcategory;

  late ExpandableController priceRangeCntrl, ratingCntrl;

  late TextEditingController minCntrl, maxCntrl;

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
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Center(
            child: SizedBox(
              width: 20.sp,
              height: 20.sp,
              child: SvgPicture.asset(AppSvg.chevronThick),
            ),
          ),
        ),
        title: AppText.sp18("Filters").w700.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.verticalSpace,
            _listTile(
              "Sub-Category",
              subcategory?.name ?? "",
              _chooseSubcategory,
            ),
            10.verticalSpace,
            _listTile(
              "Brand Name",
              brands.map((b) => b.name).join(','),
              _chooseBrandName,
            ),
            10.verticalSpace,
            _listTile(
              "Generic Name",
              genericNames.map((g) => g.name).join(','),
              _chooseGenericName,
            ),
            10.verticalSpace,
            ExpandablePanel(
              controller: priceRangeCntrl,
              header: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
                child: AppText.sp16("Price Range").w700.black,
              ),
              expanded: sliderWidget(),
              collapsed: const SizedBox.shrink(),
            ),
            10.verticalSpace,
            ExpandablePanel(
              controller: ratingCntrl,
              header: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
                child: AppText.sp16("Rating").w700.black,
              ),
              expanded: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    // 15.verticalSpace,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     AppText.sp16("All Star").w400.black,
                    //     AppRadio.circle(
                    //       value: ratingEnum == RatingEnum.all,
                    //       onChanged: (v) {
                    //         setState(() => ratingEnum = RatingEnum.all);
                    //       },
                    //     ),
                    //   ],
                    // ),
                    15.verticalSpace,
                    _starRow(RatingEnum.five),
                    15.verticalSpace,
                    _starRow(RatingEnum.four),
                    15.verticalSpace,
                    _starRow(RatingEnum.three),
                    15.verticalSpace,
                    _starRow(RatingEnum.two),
                    15.verticalSpace,
                    _starRow(RatingEnum.one),
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
            ),
            20.verticalSpace,
          ],
        ),
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
              rangeThumbShape: RoundRangeSliderThumbShape(
                enabledThumbRadius: 10.r,
              ),
              overlayShape: SliderComponentShape.noThumb,
              trackHeight: 4.w,
              rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
            ),
            child: RangeSlider(
              activeColor: AppColor.primary,
              inactiveColor: AppColor.lightBlue,
              min: minValue.toDouble(),
              max: maxValue.toDouble(),
              values: RangeValues(startRange, endRange),
              onChanged: (newValues) {
                startRange = newValues.start;
                endRange = newValues.end;
                minCntrl.text = TextFormater.currency(startRange);
                maxCntrl.text = TextFormater.currency(endRange);
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
        ),
      ],
    );
  }

  SizedBox _rangeEnd(String title, bool isMax, TextEditingController cntrl) {
    return SizedBox(
      width: 120.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.sp16(title).w400.setColor(AppColor.black.withOpacity(0.7)),
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
                  if (value > startRange) endRange = value;
                } else {
                  if (value < endRange) startRange = value;
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
                contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
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
                  AppText.sp12(subtitle).w500.lightGrey,
                ],
              ),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: SvgPicture.asset(
                AppSvg.chevronThick,
                height: 16.sp,
                colorFilter: const ColorFilter.mode(
                  AppColor.darkGrey,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _starRow(RatingEnum rating) {
    int filled = rating.starCount ?? 0;
    int unfilled = 5 - filled;
    return Row(
      children: [
        ...List.generate(filled, (idx) {
          return Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: SvgPicture.asset(
              AppSvg.starFilled,
              colorFilter: const ColorFilter.mode(
                AppColor.primary,
                BlendMode.srcIn,
              ),
            ),
          );
        }),
        ...List.generate(unfilled, (idx) {
          return Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: SvgPicture.asset(
              AppSvg.starFilled,
              colorFilter: const ColorFilter.mode(
                AppColor.lightGrey,
                BlendMode.srcIn,
              ),
            ),
          );
        }),
        const Spacer(),
        AppRadio.circle(
          value: rating == ratingEnum,
          onChanged: (v) {
            setState(() => ratingEnum = rating);
          },
        ),
      ],
    );
  }

  void reset([ExploreFilter? newFilter]) {
    final filter = newFilter ?? context.read<ExploreCubit>().state.data.filter;
    endRange = (filter.maxPrice ?? maxValue).toDouble();
    startRange = (filter.minPrice ?? 0).toDouble();
    minCntrl = TextEditingController(text: TextFormater.currency(startRange));
    maxCntrl = TextEditingController(text: TextFormater.currency(endRange));
    ratingEnum = RatingEnum.fromInt(filter.stars);
    brands = filter.brandNames.toSet();
    genericNames = filter.genericNames.toSet();
    subcategory = filter.subCategory.firstOrNull;
  }

  Future _chooseBrandName() async {
    brands =
        await Navigator.push<Set<GenericBrandName>?>(
          context,
          AppUtils.transition(
            ExploreBrandNamePage(
              brandNames: brands,
              nameType: ExploreNameEnum.brand,
            ),
          ),
        ) ??
        brands;
    setState(() {});
  }

  Future _chooseGenericName() async {
    genericNames =
        await Navigator.push<Set<GenericBrandName>?>(
          context,
          AppUtils.transition(
            ExploreBrandNamePage(
              brandNames: genericNames,
              nameType: ExploreNameEnum.generic,
            ),
          ),
        ) ??
        genericNames;
    setState(() {});
  }

  Future _chooseSubcategory() async {
    MajorCategory? catData =
        context.read<ExploreCubit>().state.data.filter.category;
    subcategory =
        await Navigator.push<SubCategory?>(
          context,
          AppUtils.transition(
            ExploreSubcategoryPage(
              subcategory: subcategory,
              categoryId: catData.id,
            ),
          ),
        ) ??
        subcategory;
    setState(() {});
  }

  void _discard() {
    minCntrl.dispose();
    maxCntrl.dispose();
    // final filter = ExploreFilter.initial();
    // context.read<ExploreBloc>().add(UpdateFilter(filter, false));
    reset(ExploreFilter.initial());

    setState(() {});
  }

  void _save() {
    final filter = context.read<ExploreCubit>().state.data.filter.copy(
      brandNames: brands.toList(),
      genericNames: genericNames.toList(),
      subCategory: subcategory == null ? [] : [subcategory!],
      minPrice: startRange.round(),
      maxPrice: endRange.round(),
      stars: ratingEnum.starCount ?? -1,
    );

    context.read<ExploreCubit>().updateFilter(filter);
    Navigator.pop(context);
  }
}
