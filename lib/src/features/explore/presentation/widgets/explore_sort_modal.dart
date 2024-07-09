import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/enum/sort_type_enum.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/features/explore/presentation/bloc/explore_bloc/explore_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreSortModal extends StatelessWidget {
  const ExploreSortModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.r),
      ),
      color: AppColor.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
        child: BlocBuilder<ExploreBloc, ExploreState>(
          builder: (context, state) {
            final succesState = state as ExploreSuccess;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.h),
                    color: AppColor.lightGrey,
                  ),
                ),
                5.verticalSpace,
                AppText.sp18("Sort by").w500.black,
                25.verticalSpace,
                ...SortTypeEnum.values.map(
                  (sT) => Padding(
                    padding: EdgeInsets.only(bottom: 25.h),
                    child: sortListType(sT, succesState.sortType == sT, () {
                      context
                          .read<ExploreBloc>()
                          .add(ChangeExploreSort(sortType: sT));
                    }),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget sortListType(
      SortTypeEnum sortType, bool selected, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? AppColor.primary : null,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: AppText.sp16(sortType.displayName).w500.setColor(
              selected ? AppColor.white : AppColor.black,
            ),
      ),
    );
  }
}
