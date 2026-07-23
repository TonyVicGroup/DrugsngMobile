import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressLabelWidget extends StatelessWidget {
  final bool selected;
  final void Function() onTap;
  final String text;

  const AddressLabelWidget({
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
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(
            width: 1,
            color: selected ? AppColor.primary : AppColor.darkGrey,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20.r,
              height: 20.r,
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColor.primary : AppColor.darkGrey,
                ),
              ),
              child:
                  selected
                      ? Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.primary,
                        ),
                      )
                      : null,
            ),
            6.horizontalSpace,
            AppText.sp16(
              text,
            ).w400.setColor(selected ? AppColor.primary : AppColor.darkGrey),
          ],
        ),
      ),
    );
  }
}
