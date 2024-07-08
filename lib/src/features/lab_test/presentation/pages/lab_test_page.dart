import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/extensions/widget_extension.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/ui/app_text_field.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/checkout/presentation/pages/cart_page.dart';
import 'package:drugs_ng/src/features/explore/presentation/pages/explore_search_page.dart';
import 'package:drugs_ng/src/features/home/presentation/widgets/home_carousel_widget.dart';
import 'package:drugs_ng/src/features/home/presentation/widgets/location_chip.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/diagnostic_test.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/test_package.dart';
import 'package:drugs_ng/src/features/lab_test/presentation/cubit/lab_test_cubit.dart';
import 'package:drugs_ng/src/features/lab_test/presentation/pages/lab_test_discovery.dart';
import 'package:drugs_ng/src/features/lab_test/presentation/widgets/diagnostic_test_widget.dart';
import 'package:drugs_ng/src/features/lab_test/presentation/widgets/test_package_widget.dart';
import 'package:drugs_ng/src/features/notification/presentation/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabTestPage extends StatefulWidget {
  const LabTestPage({super.key});

  @override
  State<LabTestPage> createState() => _LabTestPageState();
}

class _LabTestPageState extends State<LabTestPage> {
  @override
  void initState() {
    super.initState();
    context.read<LabTestCubit>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LabTestCubit, LabTestState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LabTestLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              await context.read<LabTestCubit>().reload();
            },
            child: SafeArea(
              bottom: false,
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
                              onTap: () => notification(context),
                            ),
                            15.horizontalSpace,
                            AppButton.svgIcon(
                              svg: AppSvg.shopping,
                              onTap: () => cart(context),
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
                      onTap: () => search(context),
                    ),
                  ),
                  30.verticalSpace,
                  HomeCarouselWidget(
                    ads: state.data.ads,
                  ),
                  30.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.sp16("New Arrivals").w500.black,
                        AppText.sp14("View All")
                            .w400
                            .primaryColor
                            .clickable(viewAllDiagnosticTest),
                      ],
                    ),
                  ),
                  2.verticalSpace,
                  SizedBox(
                    height: 255.h,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 15.h,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        DiagnosticTest test = state.data.tests[index];
                        return DiagnosticTestWidget(test: test);
                      },
                      separatorBuilder: (context, index) => 15.horizontalSpace,
                      itemCount: state.data.tests.length,
                    ),
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.sp16("Test Packages").w500.black,
                        AppText.sp14("View All")
                            .w400
                            .primaryColor
                            .clickable(viewAllTestPackages),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 225.h,
                    child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          TestPackage package = state.data.packages[index];
                          return TestPackageWidget(
                            package: package,
                            width: 295.w,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            15.horizontalSpace,
                        itemCount: state.data.packages.length),
                  ),
                  80.verticalSpace,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void search(BuildContext context) {
    Navigator.push(
      context,
      AppUtils.transition(const ExploreSearchPage()),
    );
  }

  void notification(BuildContext context) {
    Navigator.push(
      context,
      AppUtils.transition(const NotificationPage()),
    );
  }

  void cart(BuildContext context) {
    Navigator.push(
      context,
      AppUtils.transition(const CartPage()),
    );
  }

  void viewAllDiagnosticTest() {
    Navigator.push(
      context,
      AppUtils.transition(
        const LabTestDiscovery(tabIndex: 0),
      ),
    );
  }

  void viewAllTestPackages() {
    Navigator.push(
      context,
      AppUtils.transition(
        const LabTestDiscovery(tabIndex: 1),
      ),
    );
  }
}
