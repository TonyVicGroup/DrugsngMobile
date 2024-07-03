import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderSelectWidget extends StatelessWidget {
  final bool selected;
  final void Function() onTap;
  final String text;

  const GenderSelectWidget({
    super.key,
    required this.selected,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: AppColor.darkGrey),
        ),
        child: Row(
          children: [
            Container(
              width: 20.r,
              height: 20.r,
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.darkGrey),
              ),
              child: selected
                  ? Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.darkGrey,
                      ),
                    )
                  : null,
            ),
            6.horizontalSpace,
            AppText.sp16(text).w400.darkGrey,
          ],
        ),
      ),
    );
  }
}
