import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/home/presentation/pages/doctor_home.dart';
import 'package:drugs_ng/features/navigation/domain/entities/nav_item.dart';
import 'package:drugs_ng/features/navigation/presentation/widgets/app_bottom_nav_bar_widget.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class DoctorTabView extends StatelessWidget {
  const DoctorTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: TabBarView(
              controller: AppUtils.tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const DoctorHome(),
                Container(color: Colors.green),
                Container(color: Colors.blue),
                Container(color: Colors.yellow),
                Container(color: Colors.pink),
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
                NavItem(title: "Calendar", svg: Assets.svg.calendar),
                NavItem(title: "Patients", svg: Assets.svg.people),
                NavItem(title: "Wallet", svg: Assets.svg.wallet),
                NavItem(title: "Settings", svg: Assets.svg.setting),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
