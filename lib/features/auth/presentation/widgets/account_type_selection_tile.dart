import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountTypeSelectionTile extends StatelessWidget {
  const AccountTypeSelectionTile({
    super.key,
    required this.isSelected,
    required this.title,
    required this.subtitle,
    required this.svg,
    required this.onTap,
  });

  final bool isSelected;
  final String title;
  final String subtitle;
  final String svg;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppButtonAnimator(
      onTap: onTap,
      animationOffset: 0.99,
      child: Container(
        height: 248.h,
        width: double.maxFinite,
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColor.color0B8AE1.withAlpha(13)
                  : AppColor.colorFFFFFF,
          borderRadius: BorderRadius.circular(16.r),
          // boxShadow: AppColor.shadow,
          border: Border.all(
            color: isSelected ? AppColor.color0B8AE1 : AppColor.colorF0F0F0,
            width: 2.r,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.r,
              height: 80.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.color0B8AE1.withAlpha(25),
              ),
              child: CustomImage(
                svg,
                width: 40.r,
                height: 40.r,
                color: AppColor.color0B8AE1,
              ),
            ),
            8.verticalSpace,
            AppText.sp18(title).w600.setColor(AppColor.color333333).centerText,
            8.verticalSpace,
            AppText.sp13(
              subtitle,
            ).w400.setColor(AppColor.color666666).centerText,
            8.verticalSpace,
            Container(
              height: 24.r,
              width: 24.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColor.color0B8AE1 : null,
                border: Border.all(
                  color:
                      isSelected ? AppColor.color0B8AE1 : AppColor.colorE0E0E0,
                  width: 2.r,
                ),
              ),
              child:
                  isSelected
                      ? CustomImage(
                        Assets.svg.checkmark,
                        width: 12.r,
                        color: AppColor.colorFFFFFF,
                      )
                      : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
