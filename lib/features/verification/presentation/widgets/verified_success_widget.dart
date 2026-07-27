import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/verification/domain/entities/verify_list_tile_entity.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum VerifyType {
  face,
  identity;

  bool get isFace => this == face;
  bool get isIdentity => this == identity;
}

class VerifiedSuccessWidget extends StatelessWidget {
  const VerifiedSuccessWidget._({
    required this.items,
    required this.type,
    required this.onNext,
    required this.title,
    required this.subtitle,
  });

  factory VerifiedSuccessWidget.identity({
    required List<VerifyListTileEntity> items,
    required void Function() onNext,
    required String title,
    required String subtitle,
  }) => VerifiedSuccessWidget._(
    items: items,
    type: VerifyType.identity,
    onNext: onNext,
    title: title,
    subtitle: subtitle,
  );

  factory VerifiedSuccessWidget.face({
    required List<VerifyListTileEntity> items,
    required void Function() onNext,
    required String title,
    required String subtitle,
  }) => VerifiedSuccessWidget._(
    items: items,
    type: VerifyType.face,
    onNext: onNext,
    title: title,
    subtitle: subtitle,
  );

  final List<VerifyListTileEntity> items;
  // ignore: library_private_types_in_public_api
  final VerifyType type;
  final void Function() onNext;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          decoration: BoxDecoration(
            color: AppColor.colorFFFFFF,
            boxShadow: AppColor.shadow,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 104.r,
                height: 104.r,
                alignment: Alignment.center,
                // padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.color0B8AE1.withAlpha(20)),
                ),
                child: Container(
                  width: 88.r,
                  height: 88.r,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.color0B8AE1.withAlpha(20),
                  ),
                  child: CustomImage(
                    Assets.svg.checkmark,
                    width: 32.r,
                    height: 32.r,
                    color: AppColor.color0B8AE1,
                  ),
                ),
              ),
              20.verticalSpace,
              AppText.sp20(title).w700.setColor(AppColor.color0B8AE1),
              8.verticalSpace,
              AppText.sp14(
                subtitle,
              ).w400.setColor(AppColor.color6B7280).centerText,
              16.verticalSpace,
              Container(
                // width: 230.w,
                // height: 48.h,
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppColor.color0B8AE1.withAlpha(20),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColor.color0B8AE1.withAlpha(35)),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _verifyListTile(items[index]);
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      width: double.maxFinite,
                      height: 1.3.h,
                      color: AppColor.color0B8AE1.withAlpha(25),
                    );
                  },
                  itemCount: items.length,
                ),
              ),
              if (type.isFace) ...[20.verticalSpace, nextUpWidget()],
              30.verticalSpace,
              if (type.isFace)
                AppGradientButton.suffixIcon(
                  text: 'Continue to Next Step',
                  svg: Assets.svg.arrowRight,
                  onTap: onNext,
                )
              else
                AppGradientButton.prefixIcon(
                  text: 'Verify Face Recognition',
                  svg: Assets.svg.camera,
                  onTap: onNext,
                ),
            ],
          ),
        ),
        const Spacer(flex: 3),
      ],
    );
  }

  Widget _verifyListTile(VerifyListTileEntity item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          AppText.sp13(item.title).w400.setColor(AppColor.color6B7280),
          const Spacer(),
          if (item.svg != null) ...[
            CustomImage(
              item.svg!,
              width: 15.r,
              height: 15.r,
              color: item.color,
            ),
            2.horizontalSpace,
          ],
          4.horizontalSpace,
          AppText.sp13(item.value).w600.setColor(item.color),
        ],
      ),
    );
  }

  Widget nextUpWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColor.colorF9FAFB,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.colorE5E7EB),
      ),
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.color0B8AE1.withAlpha(25),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: CustomImage(
              Assets.svg.face,
              width: 20.r,
              height: 20.r,
              color: AppColor.color0B8AE1,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.sp13(
                  'Next up: Face Recognition',
                ).w600.setColor(AppColor.color111827),
                3.99.verticalSpace,
                AppText.sp13(
                  'A quick selfie match to confirm your identity.',
                ).w400.setColor(AppColor.color6B7280),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
