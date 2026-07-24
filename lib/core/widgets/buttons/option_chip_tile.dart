import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionChipTile extends StatelessWidget {
  const OptionChipTile({
    super.key,
    required this.text,
    required this.selected,
    required this.onTap,
    this.width,
  });

  final String text;
  final bool selected;
  final void Function() onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return AppButtonAnimator(
      onTap: onTap,
      child: Container(
        width: 95.w,
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
        decoration: BoxDecoration(
          color:
              selected
                  ? AppColor.color0B8AE1.withAlpha(25)
                  : AppColor.colorF3F5F9,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Container(
              width: width ?? 17.5.r,
              height: 17.5.r,
              alignment: Alignment.center,
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColor.color0B8AE1 : AppColor.colorBDC4CD,
                  width: selected ? 2.r : 1.r,
                ),
              ),
              child:
                  selected
                      ? Container(
                        width: 14.r,
                        height: 14.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.color0B8AE1,
                        ),
                      )
                      : null,
            ),
            5.horizontalSpace,
            Expanded(
              child: AppText.sp16(text).w400
                  .setColor(
                    selected ? AppColor.color0B8AE1 : AppColor.color6D6D6D,
                  )
                  .setMaxLines(1),
            ),
          ],
        ),
      ),
    );
  }
}
