import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/navigation/app_route.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/fetch_more_indicator.dart';
import 'package:drugs_ng/core/widgets/tab_title_widget.dart';
import 'package:drugs_ng/features/home/presentation/widgets/home_header_widget.dart';
import 'package:drugs_ng/features/search/data/models/search_item.dart';
import 'package:drugs_ng/features/lab_test/domain/models/diagnostic_test.dart';
import 'package:drugs_ng/features/lab_test/domain/models/wellness_package.dart';
import 'package:drugs_ng/features/lab_test/presentation/cubit/lab_test_cubit.dart';
import 'package:drugs_ng/features/lab_test/presentation/widgets/diagnostic_test_widget.dart';
import 'package:drugs_ng/features/lab_test/presentation/widgets/wellness_package_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabTestDiscoveryPage extends StatefulWidget {
  const LabTestDiscoveryPage({super.key});

  @override
  State<LabTestDiscoveryPage> createState() => _LabTestDiscoveryPageState();

  static Route<dynamic> route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const LabTestDiscoveryPage(),
    );
  }
}

class _LabTestDiscoveryPageState extends State<LabTestDiscoveryPage> {
  PageController controller = PageController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.jumpToPage(context.read<LabTestCubit>().state.testTab ? 0 : 1);
    });
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            16.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: HomeHeaderWidget(onTap: search),
            ),
            10.verticalSpace,
            BlocBuilder<LabTestCubit, LabTestState>(
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
                            context.read<LabTestCubit>().toggleTab(v);
                            Duration duration = const Duration(
                              milliseconds: 600,
                            );
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
                          },
                        ),
                      ),
                      30.verticalSpace,
                      Expanded(
                        child: PageView.builder(
                          controller: controller,
                          itemCount: 2,
                          itemBuilder:
                              (context, index) => FetchMoreIndicator(
                                onAction:
                                    context.read<LabTestCubit>().fetchMore,
                                child:
                                    index == 0
                                        ? diagnosticTest()
                                        : wellnessPackages(),
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void search() {
    context.pushNamed(
      AppRoutes.searchPage,
      arguments: SearchType.testAndPackage,
    );
  }

  Widget wellnessPackages() {
    final state = context.read<LabTestCubit>().state;
    if (state.wellnessStatus.isInitial) {
      context.read<LabTestCubit>().getWellnessPackages();
    }
    if (state.wellnessStatus.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.wellnessStatus.isSuccess) {
      if (state.wellnessPackages.isEmpty) {
        return Center(child: AppText.sp16("No package available"));
      }
      return ListView.separated(
        padding: EdgeInsets.fromLTRB(16.w, 2.h, 16.w, 100.h),
        itemBuilder: (context, index) {
          WellnessPackage package = state.wellnessPackages[index];
          return WellnessPackageWidget(package: package);
        },
        separatorBuilder: (context, index) => 30.verticalSpace,
        itemCount: state.wellnessPackages.length,
      );
    } else {
      return Center(child: AppText.sp16("An error occured"));
    }
  }

  Widget diagnosticTest() {
    final state = context.read<LabTestCubit>().state;
    if (state.diagnosticStatus.isInitial) {
      context.read<LabTestCubit>().getDiagnosticTests();
    }
    if (state.diagnosticStatus.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.diagnosticStatus.isSuccess) {
      if (state.wellnessPackages.isEmpty) {
        return Center(child: AppText.sp16("No test available"));
      }
      return GridView.builder(
        itemCount: state.diagnosticTests.length,
        padding: EdgeInsets.fromLTRB(16.w, 2.h, 16.w, 100.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          mainAxisSpacing: 30.h,
          crossAxisSpacing: 16.w,
        ),
        itemBuilder: (context, index) {
          DiagnosticTest test = state.diagnosticTests[index];
          return DiagnosticTestWidget(test: test);
        },
      );
    } else {
      return Center(child: AppText.sp16("An error occured"));
    }
  }
}
