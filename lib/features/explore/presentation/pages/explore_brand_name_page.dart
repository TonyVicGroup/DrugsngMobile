import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_checkbox.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/fetch_more_indicator.dart';
import 'package:drugs_ng/features/explore/data/repository/explore_repository.dart';
import 'package:drugs_ng/features/explore/domain/models/generic_brand_name.dart';
import 'package:drugs_ng/features/explore/presentation/cubit/explore_names_cubit.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/explore_bottons.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/explore_search_field.dart';
import 'package:drugs_ng/features/explore/presentation/widgets/explore_subcategory_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreBrandNamePage extends StatefulWidget {
  final Set<GenericBrandName> brandNames;
  final ExploreNameEnum nameType;

  const ExploreBrandNamePage({
    super.key,
    required this.brandNames,
    required this.nameType,
  });

  @override
  State<ExploreBrandNamePage> createState() => _ExploreBrandNamePageState();
}

class _ExploreBrandNamePageState extends State<ExploreBrandNamePage> {
  late Set<GenericBrandName> genericBrands;

  @override
  void initState() {
    super.initState();
    genericBrands = Set.from(widget.brandNames);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => ExploreNamesCubit(
            context.read<ExploreRepository>(),
            widget.nameType,
          )..getNames(),
      child: Scaffold(
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
          title:
              AppText.sp18(
                widget.nameType == ExploreNameEnum.brand
                    ? "Brand Name"
                    : "Generic Name",
              ).w700.black,
          centerTitle: true,
        ),
        body: BlocBuilder<ExploreNamesCubit, ExploreNamesState>(
          builder: (context, state) {
            return Column(
              children: [
                30.verticalSpace,
                ExploreSearchField(
                  onChanged: (value) {
                    context.read<ExploreNamesCubit>().search(value ?? "");
                  },
                  onSubmitted: (value) {
                    context.read<ExploreNamesCubit>().search(value ?? "");
                  },
                ),
                20.verticalSpace,
                Expanded(
                  child:
                      state.status.isLoading
                          ? const ExploreSubCategoryLoader()
                          : FetchMoreIndicator(
                            onAction: () async {
                              await context
                                  .read<ExploreNamesCubit>()
                                  .nextPage();
                              setState(() {});
                            },
                            child: _brandNamesWidget(state),
                          ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Column _brandNamesWidget(ExploreNamesState state) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 80.h),
            itemBuilder: (context, index) {
              final brandName = state.searchResult[index];
              bool selected = genericBrands.contains(brandName);
              return InkWell(
                onTap: () {
                  if (selected) {
                    genericBrands.remove(brandName);
                  } else {
                    genericBrands.add(brandName);
                  }
                  setState(() {});
                },
                child: Row(
                  children: [
                    Expanded(child: AppText.sp16(brandName.name).w400.black),
                    10.horizontalSpace,
                    AppCheckbox.primary(value: selected),
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

  void _discard() => setState(() => genericBrands.clear());

  void _save() {
    Navigator.pop(context, genericBrands);
  }
}
