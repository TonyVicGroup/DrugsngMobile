import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/cubits/navigation_tab_cubit.dart';
import 'package:drugs_ng/core/extensions/widget_extension.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/app_text_field.dart';
import 'package:drugs_ng/core/widgets/coming_soon_widget.dart';
import 'package:drugs_ng/core/widgets/error_banner.dart';
import 'package:drugs_ng/core/widgets/error_page.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/cart_page.dart';
import 'package:drugs_ng/features/search/data/models/search_item.dart';
import 'package:drugs_ng/features/search/presentation/pages/search_page.dart';
import 'package:drugs_ng/features/home/presentation/widgets/location_chip.dart';
import 'package:drugs_ng/features/lab_test/presentation/cubit/lab_test_cubit.dart';
import 'package:drugs_ng/features/lab_test/presentation/pages/lab_test_discovery.dart';
import 'package:drugs_ng/features/lab_test/presentation/widgets/diagnostic_list_widget.dart';
import 'package:drugs_ng/features/lab_test/presentation/widgets/lab_test_carousel.dart';
import 'package:drugs_ng/features/lab_test/presentation/widgets/wellness_list_widget.dart';
import 'package:drugs_ng/features/notification/presentation/pages/notification_page.dart';
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
    // context.read<LabTestCubit>().refreshAll();
  }

  @override
  Widget build(BuildContext context) {
    return ComingSoonWidget();
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
                      20.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            LocationChip.widget(context),
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
                      Builder(
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LabTestCarousel(state: state),
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

  Future _nextPage(Widget page) async {
    context.read<NavigationTabCubit>().hide();
    await Navigator.push(context, AppUtils.transition(page));
    // ignore: use_build_context_synchronously
    context.read<NavigationTabCubit>().show();
  }

  void search(BuildContext context) {
    _nextPage(const SearchPage(searchType: SearchType.testAndPackage));
  }

  void notification(BuildContext context) {
    _nextPage(const NotificationPage());
  }

  void cart(BuildContext context) {
    _nextPage(const CartPage());
  }

  void viewAll(bool isTest) async {
    context.read<LabTestCubit>().toggleTab(isTest);
    _nextPage(const LabTestDiscovery());
  }
}
