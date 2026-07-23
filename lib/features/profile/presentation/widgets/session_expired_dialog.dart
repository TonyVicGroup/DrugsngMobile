import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SessionExpiredDialog extends StatelessWidget {
  const SessionExpiredDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PopScope(
        canPop: false,
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
                      AppText.sp14("SESSION EXPIRED").w500,
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
                AppText.sp20("Your login session has expired").w800,
                12.verticalSpace,
                AppText.sp14(
                  "Please Login again to recieve user information.",
                ).w400,
                40.verticalSpace,
                40.verticalSpace,
                InkWell(
                  onTap: () {
                    context.read<AuthCubit>().logout();
                    // AppUtils.navKey.currentState?.pushAndRemoveUntil(
                    //   AppUtils.transition(const OnboardingPage()),
                    //   (route) => route.isFirst,
                    // );
                  },
                  child: Container(
                    height: 49.h,
                    width: 326.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      color: AppColor.green,
                    ),
                    child: AppText.sp16("LOG IN").w800.white,
                  ),
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emojiButton(String svg) {
    return SvgPicture.asset(svg, width: 28.r, height: 28.r);
  }
}
