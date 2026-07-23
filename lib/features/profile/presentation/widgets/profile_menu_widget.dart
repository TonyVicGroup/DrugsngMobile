import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/cubits/navigation_tab_cubit.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/auth/presentation/pages/login_page.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/profile_update_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/pages/address_page.dart';
import 'package:drugs_ng/features/profile/presentation/pages/help_support_page.dart';
import 'package:drugs_ng/features/profile/presentation/pages/my_review_page.dart';
import 'package:drugs_ng/features/profile/presentation/pages/order_history_page.dart';
import 'package:drugs_ng/features/profile/presentation/pages/personal_info_page.dart';
import 'package:drugs_ng/features/profile/presentation/pages/wishlist_page.dart';
import 'package:drugs_ng/features/profile/presentation/widgets/login_required_modal.dart';
import 'package:drugs_ng/features/profile/presentation/widgets/logout_dialog.dart';
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
      top: 322.h,
      bottom: 30.h,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(0.05),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            _menuTile(
              AppSvg.profile,
              "Personal Info",
              () => nextPage(
                context,
                BlocProvider(
                  create:
                      (context) => ProfileUpdateCubit(
                        authCubit: context.read<AuthCubit>(),
                      ),
                  child: const PersonalInfoPage(),
                ),
                true,
              ),
            ),
            _menuTile(
              AppSvg.addresses,
              "Addresses",
              () => nextPage(context, const AddressPage(), true),
            ),
            _menuTile(
              AppSvg.orderHistory,
              "Order History",
              () => nextPage(context, const OrderHistoryPage(), true),
            ),
            _menuTile(
              AppSvg.wishlist,
              "Wishlist",
              () => nextPage(context, const WishlistPage(), true),
            ),
            _menuTile(
              AppSvg.myReviews,
              "My Reviews",
              () => nextPage(context, const MyReviewPage(), true),
            ),
            _menuTile(
              AppSvg.helpSupport,
              "Help and Support",
              () => nextPage(context, const HelpSupportPage(), false),
            ),
            if (context.read<AuthCubit>().isLoggedIn)
              _menuTile(AppSvg.logout, "Logout", () => _logout(context), true)
            else
              _menuTile(AppSvg.logout, "Login", () => _login(context)),
          ],
        ),
      ),
    );
  }

  InkWell _menuTile(
    String svg,
    String title,
    void Function() onTap, [
    bool isLogout = false,
  ]) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 40.r,
            height: 48.r,
            child: Center(
              child: SvgPicture.asset(
                svg,
                width: 16.r,
                height: 16.r,
                colorFilter: ColorFilter.mode(
                  isLogout ? AppColor.red : AppColor.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          14.horizontalSpace,
          Expanded(
            child: AppText.sp18(
              title,
            ).w400.setColor(isLogout ? AppColor.red : AppColor.black),
          ),
          20.horizontalSpace,
          if (!isLogout)
            RotatedBox(
              quarterTurns: 3,
              child: SvgPicture.asset(
                AppSvg.chevronLight,
                width: 12.r,
                colorFilter: const ColorFilter.mode(
                  AppColor.darkGrey,
                  BlendMode.srcIn,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future nextPage(BuildContext context, Widget page, bool requiresLogin) async {
    if (requiresLogin && !context.read<AuthCubit>().isLoggedIn) {
      LoginRequiredModal.show(context);
      return;
    }
    context.read<NavigationTabCubit>().hide();
    await Navigator.push(context, AppUtils.transition(page));
    // ignore: use_build_context_synchronously
    context.read<NavigationTabCubit>().show();
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
