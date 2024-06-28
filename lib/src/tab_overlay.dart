import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/ui/app_text.dart';
import 'package:drugs_ng/features/consultation/presentation/pages/consultation.dart';
import 'package:drugs_ng/features/explore/presentation/pages/explore.dart';
import 'package:drugs_ng/features/home/presentation/pages/home.dart';
import 'package:drugs_ng/features/lab_test/presentation/pages/lab_test.dart';
import 'package:drugs_ng/features/profile/presentation/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabOverlay extends StatefulWidget {
  const TabOverlay({super.key});

  @override
  State<TabOverlay> createState() => _TabOverlayState();
}

class _TabOverlayState extends State<TabOverlay>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  int tabIndex = 0;

  @override
  void initState() {
    controller = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: const [
          HomePage(),
          ExplorePage(),
          LabTestPage(),
          ConsultationPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Row(
        children: [
          _tab(AppSvg.home, "Home", 0),
          _tab(AppSvg.explore, "Explore", 1),
          _tab(AppSvg.labTest, "Lab test", 2),
          _tab(AppSvg.consultation, "Consultation", 3),
          _tab(AppSvg.profile, "Porfiles", 4),
        ],
      ),
    );
  }

  Widget _tab(String svg, String label, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            tabIndex = index;
          });
          controller.animateTo(
            index,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
          );
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
                    tabIndex == index ? AppColor.primary : AppColor.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              8.verticalSpace,
              tabIndex == index
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
