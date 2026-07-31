import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/extensions/widget_extension.dart';
import 'package:drugs_ng/core/navigation/app_route.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/error_banner.dart';
import 'package:drugs_ng/core/widgets/error_page.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/consultation_doctor_carousel.dart';
import 'package:drugs_ng/features/home/presentation/widgets/home_header_widget.dart';
import 'package:drugs_ng/features/lab_test/presentation/cubit/lab_test_cubit.dart';
import 'package:drugs_ng/features/lab_test/presentation/widgets/diagnostic_list_widget.dart';
import 'package:drugs_ng/features/lab_test/presentation/widgets/wellness_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabTestTab extends StatefulWidget {
  const LabTestTab({super.key});

  @override
  State<LabTestTab> createState() => _LabTestTabState();
}

class _LabTestTabState extends State<LabTestTab> {
  @override
  void initState() {
    super.initState();
    context.read<LabTestCubit>().refreshAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        displacement: 64.h,
        onRefresh: () async {
          await context.read<LabTestCubit>().refreshAll();
        },
        child: SafeArea(
          bottom: false,
          child: BlocBuilder<LabTestCubit, LabTestState>(
            bloc: context.read<LabTestCubit>(),
            builder: (context, state) {
              return (state.isEmpty && state.loadFailed)
                  ? ErrorPage(
                    message:
                        state.diagnosticError?.message ??
                        state.wellnessError?.message,
                  )
                  : ListView(
                    children: [
                      if (state.wellnessStatus.isFailed ||
                          state.diagnosticStatus.isFailed)
                        Builder(
                          builder: (context) {
                            String errorMsg =
                                state.wellnessError?.message ??
                                (state.diagnosticError?.message ??
                                    "An error occured");
                            return ErrorBanner(
                              text: "$errorMsg. Pull down to refresh",
                            );
                          },
                        ),
                      16.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: HomeHeaderWidget(),
                      ),
                      10.verticalSpace,
                      Builder(
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ConsultationDoctorCarousel(),
                              30.verticalSpace,
                              if (state.diagnosticTests.isNotEmpty ||
                                  state.diagnosticStatus.isLoading) ...[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText.sp16("New Arrivals").w500.black,
                                      AppText.sp14("View All").w400.primaryColor
                                          .clickable(() => viewAll(true)),
                                    ],
                                  ),
                                ),
                                2.verticalSpace,
                                DiagnosticListWidget(state: state),
                                20.verticalSpace,
                              ],
                              if (state.wellnessPackages.isNotEmpty ||
                                  state.wellnessStatus.isLoading) ...[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText.sp16("Test Packages").w500.black,
                                      AppText.sp14("View All").w400.primaryColor
                                          .clickable(() => viewAll(false)),
                                    ],
                                  ),
                                ),
                                WellnessListWidget(state),
                              ],
                              10.verticalSpace,
                            ],
                          );
                        },
                      ),
                    ],
                  );
            },
          ),
        ),
      ),
    );
  }

  void viewAll(bool isTest) async {
    context.read<LabTestCubit>().toggleTab(isTest);
    context.pushNamed(AppRoutes.labTestDiscovery);
  }
}
