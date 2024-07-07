import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/test_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestPackageWidget extends StatelessWidget {
  final TestPackage package;
  final double? width;
  const TestPackageWidget({super.key, required this.package, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 162.h,
      width: width ?? double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
              color: AppColor.black.withOpacity(0.06),
              offset: const Offset(0, 4),
              blurRadius: 20),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          image: DecorationImage(
            image: AssetImage(package.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (package.discount != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: const Color(0xFF31B5ED).withOpacity(0.5),
                ),
                child: AppText.sp12("${package.discount}% OFF").w800.white,
              )
            else
              const SizedBox.shrink(),
            AppText.sp16(package.title).w800.white,
            SizedBox(
              width: 249.w,
              child: AppText.sp12(package.text).w400.white,
            ),
            Container(
              height: 30.h,
              width: 94.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: AppColor.primary,
              ),
              child: AppText.sp12("View Tests").w800.white,
            ),
          ],
        ),
      ),
    );
  }
}
