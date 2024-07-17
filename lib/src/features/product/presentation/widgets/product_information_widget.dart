import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/data/models/product_detail.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/utils/app_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

List<(String, List<String>)> data1 = [
  (
    "Description",
    [
      "Genexa Kid's Allergy Syrup provides effective relief from allergy symptoms such as sneezing, runny nose, itchy eyes, and throat. Formulated with organic and non-GMO ingredients, it's safe and gentle for children."
    ]
  ),
  ("Brand", ["Genexa Inc."]),
  ("Delivery", ["Tomorrow before 12 PM"])
];

List<(String, List<String>)> data2 = [
  (
    "Ingredients",
    [
      "Diphenhydramine HCl 12.5 mg per 5 mL",
      "Organic blueberry flavor",
      "Organic citrus extract & More"
    ]
  ),
  ("Dosage", ["As prescribed by your doctor"]),
  (
    "Warnings",
    [
      "Not suitable for children under 2 years of age without medical advice.",
      "Consult a doctor if symptoms persist or worsen."
    ]
  )
];

class ProductInformationWidget extends StatelessWidget {
  final ProductDetail product;
  const ProductInformationWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            AppText.sp14("Price:").w400.setColor(const Color(0xFF8B96A5)),
            const Spacer(),
            AppText.sp16("₦${TextFormater.amount(product.price)}")
                .w700
                .primaryColor,
            AppText.sp12(" *final price shown at checkout")
                .w400
                .setColor(const Color(0xFF8B96A5)),
          ],
        ),
        12.verticalSpace,
        _divider(),
        12.verticalSpace,
        _infoRow("Description", [product.description]),
        _infoRow("Brand", [product.brandName]),
        _infoRow(
          "Delivery",
          [
            DateFormat("dd MMMM yyyy").format(product.deliveryTime),
          ],
        ),
        // ...data1.map((dt) => _infoRow(dt.$1, dt.$2)),
        _divider(),
        12.verticalSpace,
        _infoRow("Ingredients", []),
        _infoRow("Dosage", [product.dosage]),
        _infoRow("Warnings", [product.warning]),
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
            child: AppText.sp14("$title:").w400.setColor(
                  const Color(0xFF8B96A5),
                ),
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
        Expanded(
          child: AppText.sp14(text).w400.setColor(AppColor.darkGrey),
        ),
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
