import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:drugs_ng/src/core/utils/app_utils.dart';
import 'package:drugs_ng/src/features/prescription/presentation/pages/prescription_order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderPrescriptionWidget extends StatelessWidget {
  const OrderPrescriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156.h,
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: const Color(0xFFEAEFF5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                AppText.sp18("Order with Prescription").w800.black,
                const Spacer(),
                AppText.sp14(
                        "Upload a prescription and a pharmacist will arrange your medications.")
                    .w400
                    .setColor(
                      const Color(0xFF6D6D6D),
                    ),
                const Spacer(flex: 2),
                Row(
                  children: [
                    InkWell(
                      onTap: () => upload(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 18.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: AppText.sp14("Upload").w800.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          10.horizontalSpace,
          Image.asset(
            height: 71.h,
            AppImage.clipboard,
          ),
        ],
      ),
    );
  }

  void upload(BuildContext context) {
    Navigator.push(
      context,
      AppUtils.transition(const PrescriptionOrderPage()),
    );
  }
}
