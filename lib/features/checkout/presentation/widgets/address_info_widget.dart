import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressInfoWidget extends StatelessWidget {
  final String title;
  final String address;
  final String cityAndState;
  final String svg;
  final void Function()? onEdit;
  final void Function()? onDelete;
  final void Function()? onTap;

  const AddressInfoWidget({
    super.key,
    required this.title,
    required this.address,
    required this.cityAndState,
    required this.svg,
    this.onEdit,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 82.h,
        padding: EdgeInsets.fromLTRB(15.w, 13.h, 3.w, 13.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: const Color(0xFFEAEFF5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 48.r,
                height: 48.r,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.white,
                ),
                child: SvgPicture.asset(
                  svg,
                  width: 20.w,
                  colorFilter: const ColorFilter.mode(
                    AppColor.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppText.sp18(title).w500.black,
                  AppText.sp14(address).w400
                      .setColor(const Color(0xFF8B96A5))
                      .setMaxLines(1)
                      .setLineHeight(1),
                  AppText.sp14(cityAndState).w400
                      .setColor(const Color(0xFF8B96A5))
                      .setMaxLines(1)
                      .setLineHeight(1),
                ],
              ),
            ),
            if (onEdit != null)
              InkWell(
                onTap: onEdit,
                child: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: SvgPicture.asset(
                    AppSvg.edit,
                    width: 18.r,
                    colorFilter: const ColorFilter.mode(
                      AppColor.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            if (onDelete != null)
              InkWell(
                onTap: onDelete,
                child: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: SvgPicture.asset(
                    AppSvg.delete,
                    width: 15.r,
                    colorFilter: const ColorFilter.mode(
                      AppColor.red,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
