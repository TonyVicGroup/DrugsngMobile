import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/widget_extension.dart';
import 'package:drugs_ng/features/product/data/models/title_and_description.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDescriptionWidget extends StatelessWidget {
  const ProductDescriptionWidget({
    required this.title,
    required this.information,
    required this.warning,
    super.key,
  });

  final String title;
  final List<TitleAndDescription> information;
  final String warning;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: AppColor.colorFFFFFF,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.sp14(title).w400.setColor(AppColor.color333333),
          12.verticalSpace,
          ...information.map(
            (info) =>
                _infoRow(info.title, [info.description]).padOnly(bottom: 14.h),
          ),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColor.colorFFEAEA,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.sp14('Warning').w700.setColor(AppColor.color9A3333),
                8.verticalSpace,
                AppText.sp11(warning).w400.setColor(AppColor.color9A3333),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
