import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_radio.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/fetch_more_indicator.dart';
import 'package:drugs_ng/features/explore/data/repository/explore_repository.dart';
import 'package:drugs_ng/features/explore/domain/models/sub_category.dart';
import 'package:drugs_ng/features/explore/presentation/cubit/explore_subcategory_cubit.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/explore_bottons.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/explore_search_field.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/explore_subcategory_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreSubcategoryPage extends StatefulWidget {
  final SubCategory? subcategory;
  final int categoryId;

  const ExploreSubcategoryPage({
    super.key,
    required this.subcategory,
    required this.categoryId,
  });

  @override
  State<ExploreSubcategoryPage> createState() => _ExploreSubcategoryPageState();
}

class _ExploreSubcategoryPageState extends State<ExploreSubcategoryPage> {
  SubCategory? subcategory;

  @override
  void initState() {
    super.initState();
    subcategory = widget.subcategory;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ExploreSubcategoryCubit(context.read<ExploreRepository>())
                ..getSubcategories(widget.categoryId),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
          title: AppText.sp18("Sub-Category").w700.black,
          centerTitle: true,
        ),
        body: BlocBuilder<ExploreSubcategoryCubit, ExploreSubcategoryState>(
          builder: (context, state) {
            return Column(
              children: [
                30.verticalSpace,
                ExploreSearchField(
                  onChanged: (value) {
                    context.read<ExploreSubcategoryCubit>().search(value ?? "");
                  },
                  onSubmitted: (value) {
                    context.read<ExploreSubcategoryCubit>().search(value ?? "");
                  },
                ),
                20.verticalSpace,
                Expanded(
                  child:
                      state is ExploreSubcategoryLoading
                          ? const ExploreSubCategoryLoader()
                          : FetchMoreIndicator(
                            onAction: () async {
                              await context
                                  .read<ExploreSubcategoryCubit>()
                                  .nextPage(widget.categoryId);
                            },
                            child: _subcategoriesWidget(state),
                          ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _subcategoriesWidget(ExploreSubcategoryState state) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 80.h),
            itemBuilder: (context, index) {
              SubCategory subcategory = state.searchResult[index];
              bool selected = subcategory == this.subcategory;
              return InkWell(
                onTap: () {
                  setState(() => this.subcategory = subcategory);
                },
                child: Row(
                  children: [
                    Expanded(child: AppText.sp16(subcategory.name).w400.black),
                    10.horizontalSpace,
                    AppRadio.circle(value: selected),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => 25.verticalSpace,
            itemCount: state.searchResult.length,
          ),
        ),
        10.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DiscardButton(onTap: _discard),
              ApplyButton(onTap: _save, label: 'Continue'),
            ],
          ),
        ),
        20.verticalSpace,
      ],
    );
  }

  void _save() {
    Navigator.pop(context, subcategory);
  }

  void _discard() {
    setState(() => subcategory = null);
  }
}
