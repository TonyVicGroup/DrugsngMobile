import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_checkbox.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/features/explore/data/repository/explore_repository.dart';
import 'package:drugs_ng/src/features/explore/presentation/cubit/explore_brand_cubit.dart';
import 'package:drugs_ng/src/features/explore/presentation/widgets/explore_bottons.dart';
import 'package:drugs_ng/src/features/explore/presentation/widgets/explore_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreBrandNamePage extends StatefulWidget {
  final Set<String> brandNames;

  const ExploreBrandNamePage({super.key, required this.brandNames});

  @override
  State<ExploreBrandNamePage> createState() => _ExploreBrandNamePageState();
}

class _ExploreBrandNamePageState extends State<ExploreBrandNamePage> {
  late Set<String> brandNames;

  @override
  void initState() {
    super.initState();
    brandNames = widget.brandNames;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreBrandCubit(context.read<ExploreRepository>())
        ..getSubcategories("category"),
      child: Scaffold(
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
          title: AppText.sp18("Brand Name").w700.black,
          centerTitle: true,
        ),
        body: BlocBuilder<ExploreBrandCubit, ExploreBrandState>(
          builder: (context, state) {
            if (state is ExploreBrandLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                30.verticalSpace,
                ExploreSearchField(
                  onChanged: (value) {
                    context.read<ExploreBrandCubit>().search(value ?? "");
                  },
                  onSubmitted: (value) {
                    context.read<ExploreBrandCubit>().search(value ?? "");
                  },
                ),
                20.verticalSpace,
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 80.h),
                    itemBuilder: (context, index) {
                      String brandName = state.searchResult[index];
                      bool selected = brandNames.contains(brandName);
                      return InkWell(
                        onTap: () {
                          if (selected) {
                            brandNames.remove(brandName);
                          } else {
                            brandNames.add(brandName);
                          }
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Expanded(child: AppText.sp16(brandName).w400.black),
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
                      ApplyButton(onTap: _save),
                    ],
                  ),
                ),
                80.verticalSpace,
              ],
            );
          },
        ),
      ),
    );
  }

  void _discard() {
    setState(() {
      brandNames = widget.brandNames;
    });
  }

  void _save() {
    Navigator.pop(context, brandNames);
  }
}
