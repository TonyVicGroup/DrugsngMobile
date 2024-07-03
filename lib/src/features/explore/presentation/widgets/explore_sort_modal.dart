import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:flutter/material.dart';
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
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 52.h),
        child: Column(
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
            20.horizontalSpace,
            AppText.sp18("Sort by").w500.black,
            25.verticalSpace,
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: AppText.sp16("Arrival").w500.white,
            ),
          ],
        ),
      ),
    );
  }
}
