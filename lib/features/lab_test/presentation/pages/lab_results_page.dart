import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/buttons/app_outline_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/generic/custom_appbar_widget.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabResultsPage extends StatelessWidget {
  const LabResultsPage({super.key});

  static Route<dynamic> route(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const LabResultsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Lab Results'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,
                AppText.sp19('You have no lab results yet').w600,
                4.verticalSpace,
                AppText.sp12(
                  "Once you book your first lab test, you'll see all your test results here",
                ).w400,
                20.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
