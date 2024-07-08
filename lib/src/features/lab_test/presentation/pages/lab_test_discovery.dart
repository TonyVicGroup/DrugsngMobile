import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text_field.dart';
import 'package:drugs_ng/src/core/ui/tab_title_widget.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/checkout/presentation/pages/cart_page.dart';
import 'package:drugs_ng/src/features/explore/presentation/pages/explore_search_page.dart';
import 'package:drugs_ng/src/features/home/presentation/widgets/location_chip.dart';
import 'package:drugs_ng/src/features/lab_test/presentation/cubit/lab_test_discovery_cubit.dart';
import 'package:drugs_ng/src/features/notification/presentation/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabTestDiscovery extends StatefulWidget {
  final int tabIndex;
  const LabTestDiscovery({super.key, required this.tabIndex});

  @override
  State<LabTestDiscovery> createState() => _LabTestDiscoveryState();
}

class _LabTestDiscoveryState extends State<LabTestDiscovery> {
  late int tabIndex;
  @override
  void initState() {
    super.initState();
    tabIndex = widget.tabIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await refresh();
        },
        child: SafeArea(
            child: ListView(
          children: [
            20.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  const LocationChip(),
                  const Spacer(),
                  Row(
                    children: [
                      AppButton.svgIcon(
                        svg: AppSvg.notification,
                        onTap: notification,
                      ),
                      15.horizontalSpace,
                      AppButton.svgIcon(
                        svg: AppSvg.shopping,
                        onTap: cart,
                        color: AppColor.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            30.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppTextField.search(
                hint: "Search for health products and tests",
                onTap: search,
              ),
            ),
            30.verticalSpace,
            TabTitleWidget(
                title1: "Tests",
                title2: "Packages",
                overallWidth: 187.w,
                width1: 74.w,
                width2: 102.w,
                isTab1: tabIndex == 0,
                onChanged: (v) {})
          ],
        )),
      ),
    );
  }

  void search() {
    Navigator.push(
      context,
      AppUtils.transition(const ExploreSearchPage()),
    );
  }

  void notification() {
    Navigator.push(
      context,
      AppUtils.transition(const NotificationPage()),
    );
  }

  void cart() {
    Navigator.push(
      context,
      AppUtils.transition(const CartPage()),
    );
  }

  Future refresh() async {
    if (tabIndex == 0) {
      await context.read<LabTestDiscoveryCubit>().getTests();
    } else {
      await context.read<LabTestDiscoveryCubit>().getPackages();
    }
  }
}
