import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/navigation/app_route.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/auth/presentation/pages/login_page.dart';
import 'package:drugs_ng/features/profile/presentation/widgets/login_required_modal.dart';
import 'package:drugs_ng/features/profile/presentation/widgets/logout_dialog.dart';
import 'package:drugs_ng/features/profile/presentation/widgets/switch_to_doctor_button.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16.w,
      right: 16.w,
      top: 280.h,
      bottom: 0.h,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          30.verticalSpace,
          SwitchToDoctorButton(),
          20.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: AppColor.black.withOpacity(0.05),
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _menuTile(
                  Assets.svg.profile,
                  "Personal Info",
                  () => nextPage(context, AppRoutes.personalInfoPage, true),
                ),
                _menuTile(
                  Assets.svg.map,
                  "Addresses",
                  () => nextPage(context, AppRoutes.addressPage, true),
                ),
                _menuTile(
                  Assets.svg.orderHistory,
                  "Order History",
                  () => nextPage(context, AppRoutes.orderHistoryPage, true),
                ),
                _menuTile(
                  Assets.svg.labTest,
                  "Lab Results",
                  () => nextPage(context, AppRoutes.labResultsPage, true),
                ),
                _menuTile(
                  Assets.svg.consultations,
                  "Consultations",
                  () => nextPage(context, AppRoutes.myConsultationsPage, true),
                ),
                _menuTile(
                  Assets.svg.wishlist,
                  "Wishlist",
                  () => nextPage(context, AppRoutes.wishlistPage, true),
                ),
                _menuTile(
                  Assets.svg.myReviews,
                  "My Reviews",
                  () => nextPage(context, AppRoutes.myReviewPage, true),
                ),
                _menuTile(
                  Assets.svg.support,
                  "Help and Support",
                  () => nextPage(context, AppRoutes.helpSupportPage, false),
                ),
                _menuTile(
                  Assets.svg.raiseDispute,
                  "Raise a dispute",
                  () => nextPage(context, AppRoutes.helpSupportPage, false),
                ),
                // if (context.read<AuthCubit>().isLoggedIn)
                //   _menuTile(Assets.svg.logout, "Logout", () => _logout(context), true)
                // else
                //   _menuTile(Assets.svg.logout, "Login", () => _login(context)),
              ],
            ),
          ),
          100.verticalSpace,
        ],
      ),
    );
  }

  Widget _menuTile(
    String svg,
    String title,
    void Function() onTap, [
    bool isLogout = false,
  ]) {
    return AppButtonAnimator(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 40.r,
            height: 48.r,
            child: Center(
              child: CustomImage(
                svg,
                width: 16.r,
                height: 16.r,
                color: isLogout ? AppColor.red : AppColor.color0B8AE1,
              ),
            ),
          ),
          14.horizontalSpace,
          Expanded(
            child: AppText.sp16(
              title,
            ).w400.setColor(isLogout ? AppColor.red : AppColor.color333333),
          ),
          20.horizontalSpace,
          if (!isLogout)
            RotatedBox(
              quarterTurns: 2,
              child: SvgPicture.asset(
                Assets.svg.chevronLeft,
                width: 5.7.r,
                colorFilter: const ColorFilter.mode(
                  AppColor.color8B96A5,
                  BlendMode.srcIn,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future nextPage(
    BuildContext context,
    String routeName,
    bool requiresLogin,
  ) async {
    if (requiresLogin && !context.read<AuthCubit>().isLoggedIn) {
      LoginRequiredModal.show(context);
      return;
    }
    context.pushNamed(routeName);
  }

  void _logout(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return const LogoutDialog();
      },
    );
  }

  void _login(BuildContext context) {
    AppUtils.navKey.currentState?.push(AppUtils.transition(const LoginPage()));
  }
}
