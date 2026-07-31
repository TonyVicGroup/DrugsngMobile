import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/generic/custom_appbar_widget.dart';
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(color: AppColor.colorE8EEF4, width: 1),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48.r,
                            height: 48.r,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: AppColor.color0B8AE1,
                            ),
                          ),
                          12.horizontalSpace,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppText.sp14(
                                  'You have no lab results yet',
                                ).w700.setColor(AppColor.color1A2332),
                                5.verticalSpace,
                                AppText.sp11(
                                  "Once you book your first lab test, you'll",
                                ).w500.setColor(AppColor.color6B7280),
                              ],
                            ),
                          ),
                          10.horizontalSpace,
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 9.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: AppColor.color0B8AE1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
