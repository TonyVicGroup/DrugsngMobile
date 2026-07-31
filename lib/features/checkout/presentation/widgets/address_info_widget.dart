import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
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
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
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
                child: CustomImage(
                  svg,
                  width: 20.w,
                  color: AppColor.color0B8AE1,
                ),
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText.sp18(title).w500.black,
                  5.verticalSpace,
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: address),
                        TextSpan(text: cityAndState),
                      ],
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.color8B96A5,
                        fontFamily: AppText.fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (onEdit != null)
                  AppButtonAnimator(
                    onTap: onEdit!,
                    child: Padding(
                      padding: EdgeInsets.all(6.r),
                      child: SvgPicture.asset(
                        Assets.svg.editOutline,
                        width: 18.r,
                        colorFilter: const ColorFilter.mode(
                          AppColor.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                if (onDelete != null)
                  AppButtonAnimator(
                    onTap: onDelete!,
                    child: Padding(
                      padding: EdgeInsets.all(6.r),
                      child: SvgPicture.asset(
                        Assets.svg.deleteOutline,
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
          ],
        ),
      ),
    );
  }
}
