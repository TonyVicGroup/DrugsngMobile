import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/enum/request_status.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/ui/app_text_field.dart';
import 'package:drugs_ng/src/core/ui/tab_title_widget.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/checkout/presentation/pages/cart_page.dart';
import 'package:drugs_ng/src/features/explore/presentation/pages/explore_search_page.dart';
import 'package:drugs_ng/src/features/home/presentation/widgets/location_chip.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/diagnostic_test.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/test_package.dart';
import 'package:drugs_ng/src/features/lab_test/domain/repository/lab_test_repo.dart';
import 'package:drugs_ng/src/features/lab_test/presentation/cubit/lab_test_discovery_cubit.dart';
import 'package:drugs_ng/src/features/lab_test/presentation/widgets/diagnostic_test_widget.dart';
import 'package:drugs_ng/src/features/lab_test/presentation/widgets/test_package_widget.dart';
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
  PageController controller = PageController();
  @override
  void initState() {
    super.initState();
    tabIndex = widget.tabIndex;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            LabTestDiscoveryCubit(context.read<LabTestRepository>()),
        child: RefreshIndicator(
          onRefresh: () async {
            await refresh();
          },
          child: SafeArea(
              child: Column(
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
              BlocBuilder<LabTestDiscoveryCubit, LabTestDiscoveryState>(
                builder: (context, state) {
                  return Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: TabTitleWidget(
                              title1: "Tests",
                              title2: "Packages",
                              overallWidth: 187.w,
                              width1: 74.w,
                              width2: 102.w,
                              isTab1: state.testTab,
                              onChanged: (v) {
                                context
                                    .read<LabTestDiscoveryCubit>()
                                    .toggleTab(v);
                                Duration duration =
                                    const Duration(milliseconds: 600);
                                Curve curve = Curves.easeOut;
                                if (v) {
                                  controller.animateToPage(
                                    0,
                                    duration: duration,
                                    curve: curve,
                                  );
                                } else {
                                  controller.animateToPage(
                                    1,
                                    duration: duration,
                                    curve: curve,
                                  );
                                }
                                // setState(() {
                                //   if (v) {
                                //     tabIndex = 0;
                                //   } else {
                                //     tabIndex = 1;
                                //   }
                                // });
                              }),
                        ),
                        30.verticalSpace,
                        Expanded(
                          // child: state.testTab
                          //     ? diagnosticTest(context)
                          //     : testPackages(context),
                          child: PageView.builder(
                            controller: controller,
                            itemCount: 2,
                            itemBuilder: (context, index) => index == 0
                                ? diagnosticTest(context)
                                : testPackages(context),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          )),
        ),
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

  Widget testPackages(BuildContext context) {
    final state = context.read<LabTestDiscoveryCubit>().state;
    if (state.packageStatus == Status.initial) {
      context.read<LabTestDiscoveryCubit>().getPackages();
    }
    if (state.packageStatus == Status.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.packageStatus == Status.success) {
      return ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 2.h, 16.w, 100.h),
        itemBuilder: (context, index) {
          TestPackage package = state.packages[index];
          return TestPackageWidget(package: package);
        },
        separatorBuilder: (context, index) => 30.verticalSpace,
        itemCount: state.packages.length,
      );
    } else {
      return Center(
        child: AppText.sp16("An error occured"),
      );
    }
  }

  Widget diagnosticTest(BuildContext context) {
    final state = context.read<LabTestDiscoveryCubit>().state;
    if (state.testStatus == Status.initial) {
      context.read<LabTestDiscoveryCubit>().getTests();
    }
    if (state.testStatus == Status.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.testStatus == Status.success) {
      return GridView.builder(
        itemCount: state.tests.length,
        padding: EdgeInsets.fromLTRB(16.w, 2.h, 16.w, 100.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          mainAxisSpacing: 30.h,
          crossAxisSpacing: 16.w,
        ),
        itemBuilder: (context, index) {
          DiagnosticTest test = state.tests[index];
          return DiagnosticTestWidget(test: test);
        },
      );
    } else {
      return Center(
        child: AppText.sp16("An error occured"),
      );
    }
  }
}
