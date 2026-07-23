import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/features/lab_test/domain/models/diagnostic_test_detail.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiagnosticTestInformationWidget extends StatelessWidget {
  final DiagnosticTestDetail test;
  const DiagnosticTestInformationWidget({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            AppText.sp14("Price:").w400.setColor(const Color(0xFF8B96A5)),
            const Spacer(),
            AppText.sp16(
              "₦${TextFormater.amount(test.price)}",
            ).w700.primaryColor,
            AppText.sp12(
              " *final price shown at checkout",
            ).w400.setColor(const Color(0xFF8B96A5)),
          ],
        ),
        12.verticalSpace,
        _divider(),
        12.verticalSpace,
        _infoRow(
          "Components",
          test.components.map((comp) => comp.component).toList(),
        ),
        _infoRow("Purpose", test.purposes.map((pur) => pur.purpose).toList()),
        _infoRow("Benefits", test.benefits.map((ben) => ben.benefit).toList()),
        _divider(),
      ],
    );
  }

  Container _divider() => Container(
    width: double.maxFinite,
    height: 1,
    color: const Color(0xFFE5E5E5),
  );

  Padding _infoRow(String title, List<String> data) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140.w,
            child: AppText.sp14(
              "$title:",
            ).w400.setColor(const Color(0xFF8B96A5)),
          ),
          Expanded(
            child: Column(
              children: data.map((txt) => bulletList(txt)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Row bulletList(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dot(),
        Expanded(child: AppText.sp14(text).w400.setColor(AppColor.darkGrey)),
      ],
    );
  }

  Widget dot() => Container(
    width: 6.r,
    height: 6.r,
    margin: EdgeInsets.all(6.r),
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: AppColor.darkGrey,
    ),
  );
}
