import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_formater.dart';
import 'package:drugs_ng/features/lab_test/domain/models/wellness_package_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WellnessInformationWidget extends StatelessWidget {
  final WellnessPackageDetail package;
  const WellnessInformationWidget({super.key, required this.package});

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
              "₦${TextFormater.amount(package.price)}",
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
          "Test Includes",
          package.tests.map((tst) => tst.name).toList(),
        ),
        _infoRow(
          "Purpose",
          package.purposes.map((pur) => pur.purpose).toList(),
        ),
        // _infoRow("Collection", package.col.map((ben) => ben.benefit).toList()),
        // _infoRow("Preparation", package.benefits.map((ben) => ben.benefit).toList()),
        _infoRow("Collection", []),
        _infoRow("Preparation", []),
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
