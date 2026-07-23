import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(4.r),
        child: SizedBox(
          width: 400.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.sp14("LOGOUT").w500,
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(24.r),
                        child: SvgPicture.asset(
                          AppSvg.close,
                          width: 11.2.r,
                          height: 11.2.r,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                height: 2,
                color: const Color(0xFFE5E5E5),
              ),
              24.verticalSpace,
              AppText.sp20("You're about to log out").w800,
              // 12.verticalSpace,
              // AppText.sp14("Take a few seconds to tell us how you feel.").w400,
              // 40.verticalSpace,
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     emojiButton(AppSvg.faceWink),
              //     40.horizontalSpace,
              //     emojiButton(AppSvg.faceSatisfied),
              //     40.horizontalSpace,
              //     emojiButton(AppSvg.faceDissatisfied),
              //   ],
              // ),
              40.verticalSpace,
              InkWell(
                onTap: () {
                  AppUtils.logout(context);
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 49.h,
                  width: 326.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: AppColor.red,
                  ),
                  child: AppText.sp16("LOG OUT").w800.white,
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget emojiButton(String svg) {
    return SvgPicture.asset(svg, width: 28.r, height: 28.r);
  }
}
