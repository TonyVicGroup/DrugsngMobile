import 'package:drugs_ng/core/extensions/widget_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/lab_appbar.dart';
import 'package:drugs_ng/features/home/presentation/widgets/lab_appointments_home_widget.dart';
import 'package:drugs_ng/features/home/presentation/widgets/lab_dashboard_progress_tile.dart';
import 'package:drugs_ng/features/home/presentation/widgets/lab_revenue_home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabHome extends StatelessWidget {
  const LabHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LabAppbar(),
      body: ListView(
        children: [
          20.verticalSpace,
          Align(
            alignment: Alignment.centerLeft,
            child: AppText.sp14('Dashboard').w500.subText.padOnly(left: 20.r),
          ),
          10.verticalSpace,
          const LabDashboardProgressTile(),
          20.verticalSpace,
          const LabRevenueHomeWidget(),
          20.verticalSpace,
          const LabAppointmentsHomeWidget(),
          20.verticalSpace,
        ],
      ),
    );
  }
}
