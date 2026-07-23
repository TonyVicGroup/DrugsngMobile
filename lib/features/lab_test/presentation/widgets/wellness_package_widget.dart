import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/cubits/navigation_tab_cubit.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/lab_test/domain/models/wellness_package.dart';
import 'package:drugs_ng/features/lab_test/presentation/pages/package_overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WellnessPackageWidget extends StatelessWidget {
  final WellnessPackage package;
  final double? width;
  const WellnessPackageWidget({super.key, required this.package, this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        context.read<NavigationTabCubit>().hide();
        await Navigator.push(
          context,
          AppUtils.transition(PackageOverviewPage(productId: package.id)),
        );
        // ignore: use_build_context_synchronously
        context.read<NavigationTabCubit>().show();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: SizedBox(
          height: 162.h,
          width: width ?? double.maxFinite,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: AppColor.text.withAlpha(60),
                  child: CustomImage(package.imageUrl),
                ),
              ),
              Positioned(
                top: 12.h,
                left: 12.w,
                right: 12.w,
                bottom: 12.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // if (package.discount != null)
                    //   Container(
                    //     padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(5.r),
                    //       color: const Color(0xFF31B5ED).withOpacity(0.5),
                    //     ),
                    //     child: AppText.sp12("${package.discount}% OFF").w800.white,
                    //   )
                    // else
                    SizedBox(height: 20.h),
                    AppText.sp16(package.name).w800.white,
                    SizedBox(
                      width: 249.w,
                      child: AppText.sp12(
                        package.description,
                      ).w400.white.setMaxLines(2),
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
            ],
          ),
        ),
      ),
    );
  }
}
