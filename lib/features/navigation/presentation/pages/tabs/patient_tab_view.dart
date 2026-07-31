import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/consultation/presentation/pages/consultation_tab.dart';
import 'package:drugs_ng/features/explore/presentation/pages/explore_tab.dart';
import 'package:drugs_ng/features/home/presentation/pages/home_tab.dart';
import 'package:drugs_ng/features/lab_test/presentation/pages/lab_test_tab.dart';
import 'package:drugs_ng/features/navigation/domain/entities/nav_item.dart';
import 'package:drugs_ng/features/navigation/presentation/widgets/app_bottom_nav_bar_widget.dart';
import 'package:drugs_ng/features/profile/presentation/pages/profile_tab.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class PatientTabView extends StatelessWidget {
  const PatientTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorF3F5F9,
      body: Stack(
        children: [
          Positioned.fill(
            child: TabBarView(
              controller: AppUtils.tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const HomeTab(),
                const ExploreTab(),
                const LabTestTab(),
                const ConsultationTab(),
                const ProfileTab(),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AppBottomNavBarWidget(
              navItems: [
                NavItem(title: "Home", svg: Assets.svg.home),
                NavItem(title: "Explore", svg: Assets.svg.explore),
                NavItem(title: "Lab Test", svg: Assets.svg.labTest),
                NavItem(title: "Consultation", svg: Assets.svg.calendar),
                NavItem(title: "Profile", svg: Assets.svg.profile),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
