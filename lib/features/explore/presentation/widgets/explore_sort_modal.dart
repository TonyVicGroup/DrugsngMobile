import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/enum/sort_type_enum.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreSortModal extends StatelessWidget {
  const ExploreSortModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      color: AppColor.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
        child: BlocBuilder<ExploreCubit, ExploreState>(
          builder: (context, state) {
            // final succesState = state as ExploreSuccess;
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
                16.verticalSpace,
                AppText.sp18("Sort by").w500.black,
                24.verticalSpace,
                ...SortTypeEnum.values.map(
                  (sT) => Padding(
                    padding: EdgeInsets.only(bottom: 25.h),
                    child: sortListType(sT, state.data.sortType == sT, () {
                      context.read<ExploreCubit>().sort(sT);
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
    SortTypeEnum sortType,
    bool selected,
    void Function() onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? AppColor.primary : null,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: AppText.sp16(
          sortType.displayName,
        ).w500.setColor(selected ? AppColor.white : AppColor.black),
      ),
    );
  }
}
