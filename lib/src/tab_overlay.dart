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
    //     AppToast.warning(context, ApiError.unauthorized.message);
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
    if (authState is! LoggedInState) {
      accountType = AccountTypeEnum.user;
    } else {
      accountType = authState.account.accountType;
    }
    return BlocBuilder<NavigationTabCubit, bool>(
      builder: (context, state) {
        return Focus(
          skipTraversal: true,
          canRequestFocus: false,
          child: PersistentTabView(
            drawer:
                accountType == AccountTypeEnum.lab ? const _NavDrawer() : null,
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
      AccountTypeEnum.lab => [_tabPage(const LabHome())],
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

class _NavDrawer extends StatelessWidget {
  const _NavDrawer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 321.w,
      height: 1.sh,
      child: Material(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(25.r, 25.r, 25.r, 10.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              Row(
                children: [
                  CustomImage(AppImage.logo, height: 23.r),
                  5.horizontalSpace,
                  AppText.sp18('Drugs.NG').primaryColor.w600,
                ],
              ),
              20.verticalSpace,
              AppText.sp15('Menu').w600.subText,
              20.verticalSpace,
              _MenuButton(
                text: 'Dashboard',
                svg: AppSvg.labGgrid,
                selected: true,
                onTap: () => moveToPage(context, Container()),
              ),
              6.verticalSpace,
              _MenuButton(
                text: 'Lab Appointments',
                svg: AppSvg.labAppointment,
                selected: false,
                onTap: () => moveToPage(context, Container()),
              ),
              6.verticalSpace,
              _MenuButton(
                text: 'Lab Management',
                svg: AppSvg.ticket,
                selected: false,
                onTap: () => moveToPage(context, Container()),
              ),
              6.verticalSpace,
              _MenuButton(
                text: 'Lab Revenue',
                svg: AppSvg.wallet,
                selected: false,
                onTap: () => moveToPage(context, Container()),
                hasWarning: true,
              ),
              6.verticalSpace,
              _MenuButton(
                text: 'Lab History',
                svg: AppSvg.labHistory,
                selected: false,
                onTap: () => moveToPage(context, Container()),
                hasWarning: true,
              ),
              const Spacer(),
              _MenuButton(
                text: 'Settings',
                svg: AppSvg.labSetting,
                selected: false,
                onTap: () {},
                hasWarning: true,
              ),
              6.verticalSpace,
              _MenuButton(
                text: 'Logout',
                svg: AppSvg.labLogout,
                selected: false,
                onTap: () {},
                isLogout: true,
              ),
              6.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  void moveToPage(BuildContext context, Widget page) {
    Navigator.pop(context);
    // Navigator.push(context, MaterialPageRoute(builder: (context){
    //   return
    // }));
  }
}

class _MenuButton extends StatelessWidget {
  final String text;
  final String svg;
  final bool selected;
  final void Function() onTap;
  final bool hasWarning;
  final bool isLogout;
  const _MenuButton({
    required this.text,
    required this.svg,
    required this.selected,
    required this.onTap,
    this.hasWarning = false,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        height: 47.36.h,
        padding: EdgeInsets.symmetric(horizontal: 14.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: selected ? AppColor.primary : null,
        ),
        child: Row(
          children: [
            CustomImage(
              svg,
              width: 18.r,
              height: 18.r,
              color:
                  isLogout
                      ? AppColor.red
                      : (selected ? AppColor.white : AppColor.subText),
            ),
            10.horizontalSpace,
            Expanded(
              child: AppText.sp15(text).w500.setColor(
                isLogout
                    ? AppColor.red
                    : (selected ? AppColor.white : AppColor.subText),
              ),
            ),
            if (hasWarning)
              CustomImage(
                AppSvg.infoCircle,
                width: 18.r,
                height: 18.r,
                color: AppColor.red,
              ),
          ],
        ),
      ),
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
          AccountTypeEnum.lab => <Widget>[],
        };
        if (userType.isLab) {
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
