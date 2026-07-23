import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/order_history_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/widgets/profile_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = context.read<AuthCubit>().state.user;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0).withOpacity(0.5),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 246.h,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF0B8AE1), Color(0xFF2B78CA)],
                ),
              ),
            ),
          ),
          Positioned(
            left: 16.w,
            right: 16.w,
            height: 96.h,
            top: 197.h,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
                    builder: (context, state) {
                      int orders =
                          state.inProgress.length + state.settled.length;
                      if (state.inProgressStatus.isInitial) {
                        context.read<OrderHistoryCubit>().getInProgress();
                      } else if (state.inProgressStatus.isSuccess &&
                          state.settledStatus.isInitial) {
                        context.read<OrderHistoryCubit>().getSettled();
                      }
                      return profileIcon(AppImage.package, "$orders Orders");
                    },
                  ),
                  // profileIcon(AppImage.microscope, "0 Lab test"),
                  // profileIcon(AppImage.womanHealthWorker, "0 Consultations"),
                ],
              ),
            ),
          ),
          // menu item
          const ProfileMenuWidget(),
          Positioned(
            top: 64.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText.sp16(
                        "Hello, ${userData?.firstName} ${userData?.lastName}",
                      ).w700.white,
                      8.verticalSpace,
                      AppText.sp12("How are you feeling today?").w400.white,
                      8.verticalSpace,
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 13.r,
                              vertical: 6.r,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: const Color(0xFFEDF8FF),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AppSvg.idCard,
                                  width: 13.r,
                                  height: 13.r,
                                  colorFilter: const ColorFilter.mode(
                                    AppColor.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                5.horizontalSpace,
                                AppText.sp12(
                                  "ID: ${context.read<AuthCubit>().state.user?.id ?? ''}",
                                ).w400.primaryColor,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 68.r,
                  height: 68.r,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 66.r,
                          height: 66.r,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFEDF8FF),
                            // image: DecorationImage(
                            //   image: AssetImage(AppImage.testAvatar),
                            // ),
                          ),
                          child:
                              AppText.sp25(
                                userData?.avatar ?? '',
                              ).w700.primaryColor,
                        ),
                      ),
                      // Positioned(
                      //   bottom: 0,
                      //   right: 0,
                      //   child: Container(
                      //     width: 20.r,
                      //     height: 20.r,
                      //     alignment: Alignment.center,
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       border: Border.all(color: AppColor.white),
                      //       color: const Color(0xFFEDF8FF),
                      //     ),
                      //     child: SvgPicture.asset(
                      //       AppSvg.camera,
                      //       width: 8.7.r,
                      //       height: 8.7.r,
                      //       colorFilter: const ColorFilter.mode(
                      //         AppColor.primary,
                      //         BlendMode.srcIn,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profileIcon(String image, String text) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(image, width: 32.r, height: 32.r),
          AppText.sp12(text).w400,
        ],
      ),
    );
  }
}
