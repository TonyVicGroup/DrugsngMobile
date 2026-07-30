import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/navigation/app_route.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/home/presentation/widgets/location_chip.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColor.colorFFFFFF,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        children: [
          LocationChip.widget(context),
          const Spacer(),
          CustomImage(Assets.images.drugs.path, width: 35.w),
          5.horizontalSpace,
          AppText.sp14('DrugsNG').w400.setColor(AppColor.color0B8AE1),
          const Spacer(),
          AppButtonAnimator(
            onTap: () => _openNotification(context),
            child: Container(
              width: 37.r,
              height: 37.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.colorDBE2EA,
              ),
              child: Stack(
                children: [
                  Align(
                    child: CustomImage(
                      Assets.svg.bell,
                      color: AppColor.color333333,
                      width: 19.r,
                      height: 19.r,
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.35, -0.35),
                    child: Container(
                      width: 8.r,
                      height: 8.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.colorFF5252,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          10.horizontalSpace,
          AppButtonAnimator(
            onTap: () => _openCart(context),
            child: Container(
              width: 37.r,
              height: 37.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.colorDBE2EA,
              ),
              child: CustomImage(
                Assets.svg.shoppingCart,
                color: AppColor.color333333,
                width: 19.r,
                height: 19.r,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openCart(BuildContext context) {
    context.pushNamed(AppRoutes.cartPage);
  }

  void _openNotification(BuildContext context) {
    context.pushNamed(AppRoutes.notificationPage);
  }
}
