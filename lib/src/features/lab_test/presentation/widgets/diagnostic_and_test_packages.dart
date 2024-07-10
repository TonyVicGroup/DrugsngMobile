import 'package:drugs_ng/src/core/enum/request_status.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/diagnostic_test.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/test_package.dart';
import 'package:drugs_ng/src/features/lab_test/presentation/cubit/lab_test_discovery_cubit.dart';
import 'package:drugs_ng/src/features/lab_test/presentation/widgets/diagnostic_test_widget.dart';
import 'package:drugs_ng/src/features/lab_test/presentation/widgets/test_package_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiagnosticTestAndPackages extends StatelessWidget {
  final PageController controller;
  const DiagnosticTestAndPackages({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LabTestDiscoveryCubit, LabTestDiscoveryState>(
      builder: (context, state) {
        return Expanded(
          child: PageView.builder(
              controller: controller,
              itemCount: 2,
              itemBuilder: (context, index) => (index == 0)
                  ? diagnosticTest(context)
                  : testPackages(context)),
        );
      },
    );
  }

  Widget testPackages(BuildContext context) {
    final state = context.read<LabTestDiscoveryCubit>().state;
    if (state.packageStatus == Status.initial) {
      context.read<LabTestDiscoveryCubit>().getTests();
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
      context.read<LabTestDiscoveryCubit>().getPackages();
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
