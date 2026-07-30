import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSpecificationWidget extends StatelessWidget {
  const ProductSpecificationWidget({
    required this.quantity,
    required this.form,
    required this.size,
    super.key,
  });
  final ValueNotifier<int> quantity;
  final String form;
  final String size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        // border: Border.all(color: AppColor.lightGrey),
        color: AppColor.color0B8AE1.withAlpha(35),
      ),
      child: Row(
        children: [
          _info(form, "Form"),
          _divider(),
          _info(size, "Size"),
          _divider(),
          _quantityInfo(),
          // _info(quantity.toString(), "Quantity"),
        ],
      ),
    );
  }

  Container _divider() =>
      Container(height: 44.h, width: 1, color: const Color(0xFFBDC4CD));

  Expanded _info(String value, String title) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.sp16(
                  value,
                ).w500.setColor(AppColor.color333333).setMaxLines(2),
                // 7.verticalSpace,
                AppText.sp12(title).w400.setColor(AppColor.color333333),
              ],
            ),
          ),
          8.horizontalSpace,
          CustomImage(
            Assets.svg.chevronDown,
            width: 10.w,
            color: AppColor.color333333,
          ),
          16.horizontalSpace,
        ],
      ),
    );
  }

  Expanded _quantityInfo() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                _quantityButton(false),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 50.w),
                    child: ValueListenableBuilder(
                      valueListenable: quantity,
                      builder: (context, value, child) {
                        return AppText.sp16(
                          "$value",
                        ).w500.setColor(AppColor.color333333);
                      },
                    ),
                  ),
                ),
                _quantityButton(true),
              ],
            ),
            AppText.sp12('Quantity').w400.setColor(AppColor.color333333),
          ],
        ),
      ),
    );
  }

  Widget _quantityButton(bool isPlus) {
    return AppButtonAnimator(
      onTap: () {
        if (isPlus) {
          quantity.value++;
        } else {
          if (quantity.value > 0) {
            quantity.value--;
          }
        }
      },
      child: Container(
        width: 25.r,
        height: 25.r,
        decoration: BoxDecoration(
          color: AppColor.colorFFFFFF,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(isPlus ? 0 : 5.r),
            right: Radius.circular(isPlus ? 5.r : 0),
          ),
        ),
        alignment: Alignment.center,
        child: Icon(
          isPlus ? Icons.add : Icons.remove,
          size: 16.r,
          color: AppColor.color333333,
        ),
        // child: CustomImage(
        //   isPlus ? Assets.svg.plus : Assets.svg.minus,
        //   width: 9.w,
        //   color: AppColor.color333333,
        // ),
      ),
    );
  }
}
