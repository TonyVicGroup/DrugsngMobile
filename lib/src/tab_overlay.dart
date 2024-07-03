import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/consultation/presentation/pages/consultation.dart';
import 'package:drugs_ng/src/features/explore/presentation/pages/explore_page.dart';
import 'package:drugs_ng/src/features/home/presentation/pages/home.dart';
import 'package:drugs_ng/src/features/lab_test/presentation/pages/lab_test.dart';
import 'package:drugs_ng/src/features/profile/presentation/pages/profile.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: AppUtils.tabController,
      tabs: [
        PersistentTabConfig(
            screen: const HomePage(),
            item: ItemConfig(icon: const Icon(Icons.home))),
        PersistentTabConfig(
            screen: const ExplorePage(),
            item: ItemConfig(icon: const Icon(Icons.home))),
        PersistentTabConfig(
            screen: const LabTestPage(),
            item: ItemConfig(icon: const Icon(Icons.home))),
        PersistentTabConfig(
            screen: const ConsultationPage(),
            item: ItemConfig(icon: const Icon(Icons.home))),
        PersistentTabConfig(
            screen: const ProfilePage(),
            item: ItemConfig(icon: const Icon(Icons.home))),
      ],
      navBarBuilder: (navBarConfig) => _CustomNavbar(
        navBarConfig: navBarConfig,
        navBarDecoration: const NavBarDecoration(
          border: Border(
            top: BorderSide(
              color: AppColor.black,
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomNavbar extends StatelessWidget {
  final NavBarConfig navBarConfig;
  final NavBarDecoration navBarDecoration;

  const _CustomNavbar(
      {required this.navBarConfig, required this.navBarDecoration});

  @override
  Widget build(BuildContext context) {
    return DecoratedNavBar(
      // decoration: navBarDecoration,
      // filter: navBarConfig.selectedItem.filter,
      // opacity: navBarConfig.selectedItem.opacity,
      // height: navBarConfig.navBarHeight,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _tab(AppSvg.home, "Home", 0, navBarConfig.selectedIndex == 0),
          _tab(AppSvg.explore, "Explore", 1, navBarConfig.selectedIndex == 1),
          _tab(AppSvg.labTest, "Lab test", 2, navBarConfig.selectedIndex == 2),
          _tab(AppSvg.consultation, "Consultation", 3,
              navBarConfig.selectedIndex == 3),
          _tab(AppSvg.profile, "Porfiles", 4, navBarConfig.selectedIndex == 4),
        ],
      ),
    );
  }

  Widget _tab(String svg, String label, int index, bool selected) {
    return Expanded(
      child: InkWell(
        onTap: () {
          navBarConfig.onItemSelected(index);
        },
        child: SizedBox(
          height: 84.h,
          child: Column(
            children: [
              const Spacer(),
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
              selected
                  ? AppText.sp10(label).w700.primaryColor
                  : AppText.sp10(label).w400.lightGrey,
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
