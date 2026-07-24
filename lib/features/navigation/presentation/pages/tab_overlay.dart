import 'dart:async';

import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/cubits/navigation_tab_cubit.dart';
import 'package:drugs_ng/core/enum/account_type_enum.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/consultation/presentation/pages/doctor_consultation_screen.dart';
import 'package:drugs_ng/features/doctor_appointment/presentation/pages/appointment_screen.dart';
import 'package:drugs_ng/features/explore/presentation/pages/explore_page.dart';
import 'package:drugs_ng/features/home/presentation/pages/doctor_home.dart';
import 'package:drugs_ng/features/home/presentation/pages/home.dart';
import 'package:drugs_ng/features/home/presentation/pages/lab_home.dart';
import 'package:drugs_ng/features/profile/presentation/pages/doctor_profile_screen.dart';
import 'package:drugs_ng/features/profile/presentation/pages/profile.dart';
import 'package:drugs_ng/features/wallet/presentation/pages/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class TabOverlay extends StatefulWidget {
  const TabOverlay({super.key});

  @override
  State<TabOverlay> createState() => _TabOverlayState();
}

class _TabOverlayState extends State<TabOverlay> {
  @override
  void initState() {
    AppUtils.tabController = PersistentTabController();
    // listen for 401 errors globally
    // _errorStream = context.read<RestService>().errorStream.listen((event) {
    //   if (event.statusCode == 401) {
    //     context.read<AuthCubit>().logout();
    //     AppToast.warn(context, ApiError.unauthorized.message);
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    AppUtils.tabController = null;
    // _errorStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    late final AccountTypeEnum accountType;
    if (authState.isLoggedIn) {
      accountType = AccountTypeEnum.user;
    } else {
      accountType = authState.account!.accountType;
    }
    return BlocBuilder<NavigationTabCubit, bool>(
      builder: (context, state) {
        return Focus(
          skipTraversal: true,
          canRequestFocus: false,
          child: PersistentTabView(
            controller: AppUtils.tabController,
            navBarOverlap: const NavBarOverlap.none(),
            hideNavigationBar: state,
            screenTransitionAnimation: const ScreenTransitionAnimation(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
            tabs: pages(accountType),
            navBarBuilder:
                (navBarConfig) => _CustomNavbar(
                  navBarConfig: navBarConfig,
                  userType: accountType,
                  navBarDecoration: const NavBarDecoration(
                    border: Border(top: BorderSide(color: AppColor.black)),
                  ),
                ),
          ),
        );
      },
    );
  }

  List<PersistentTabConfig> pages(AccountTypeEnum accountType) {
    // change this later to check if user is doctor or patient
    return switch (accountType) {
      AccountTypeEnum.user => [
        _tabPage(const HomePage()),
        _tabPage(const ExplorePage()),
        // _tabPage(const LabTestPage()),
        // _tabPage(const ConsultationPage()),
        _tabPage(const ProfilePage()),
      ],
      AccountTypeEnum.delivery => [_tabPage(const LabHome())],
      AccountTypeEnum.doctor => [
        _tabPage(const DoctorHome()),
        _tabPage(const AppointmentScreen()),
        _tabPage(const DoctorConsultationScreen()),
        _tabPage(const WalletScreen()),
        _tabPage(const DoctorProfileScreen()),
      ],
    };
  }

  PersistentTabConfig _tabPage(Widget page) {
    return PersistentTabConfig(
      screen: FocusScope(child: page),
      item: ItemConfig(icon: const Icon(Icons.home)),
    );
  }
}

class _CustomNavbar extends StatelessWidget {
  final NavBarConfig navBarConfig;
  final NavBarDecoration navBarDecoration;
  final AccountTypeEnum userType;

  const _CustomNavbar({
    required this.navBarConfig,
    required this.navBarDecoration,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final bottomNav = switch (userType) {
          AccountTypeEnum.user => [
            _tab(AppSvg.home, "Home", 0, navBarConfig.selectedIndex == 0),
            _tab(AppSvg.explore, "Explore", 1, navBarConfig.selectedIndex == 1),
            // _tab(
            //   AppSvg.labTest,
            //   "Lab test",
            //   2,
            //   navBarConfig.selectedIndex == 2,
            // ),
            // _tab(
            //   AppSvg.consultation,
            //   "Consultation",
            //   3,
            //   navBarConfig.selectedIndex == 3,
            // ),
            _tab(
              AppSvg.profile,
              "Profiles",
              2,
              navBarConfig.selectedIndex == 2,
            ),
          ],
          AccountTypeEnum.doctor => [
            _tab(AppSvg.home, "Home", 0, navBarConfig.selectedIndex == 0),
            _tab(
              AppSvg.appointment,
              "Appointment",
              1,
              navBarConfig.selectedIndex == 1,
            ),
            _tab(
              AppSvg.doctorConsultation,
              "Consultation",
              2,
              navBarConfig.selectedIndex == 2,
            ),
            _tab(AppSvg.wallet, "Wallet", 3, navBarConfig.selectedIndex == 3),
            _tab(
              AppSvg.profile,
              "Profiles",
              4,
              navBarConfig.selectedIndex == 4,
            ),
          ],
          AccountTypeEnum.delivery => <Widget>[],
        };
        if (userType.isDelivery) {
          return const SizedBox.shrink();
        }
        return DecoratedNavBar(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: bottomNav,
          ),
        );
      },
    );
  }

  Widget _tab(String svg, String label, int index, bool selected) {
    return Expanded(
      child: InkWell(
        onTap: () => navBarConfig.onItemSelected(index),
        child: SizedBox(
          height: 84.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 22.r,
                height: 22.r,
                child: SvgPicture.asset(
                  svg,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    selected ? AppColor.primary : AppColor.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              8.verticalSpace,
              if (selected)
                AppText.sp10(label).w700.primaryColor
              else
                AppText.sp10(label).w400.lightGrey,
            ],
          ),
        ),
      ),
    );
  }
}
