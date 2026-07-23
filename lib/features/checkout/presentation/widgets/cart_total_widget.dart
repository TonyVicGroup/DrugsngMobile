import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartTotalWidget extends StatelessWidget {
  final double total;
  final double deliveryFee;
  final double subTotal;
  final void Function() onProceed;
  const CartTotalWidget({
    super.key,
    required this.total,
    required this.subTotal,
    required this.deliveryFee,
    required this.onProceed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 13.h),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.sp18("Cart Total").w500.black,
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.only(left: 28.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(child: AppText.sp14("Subtotal:").w400.black),
                    Expanded(
                      child:
                          AppText.sp14(
                            "₦${TextFormater.amount(subTotal)}",
                          ).w400.black.endAlign,
                    ),
                  ],
                ),
                24.verticalSpace,
                Row(
                  children: [
                    Expanded(child: AppText.sp14("Delivery Fee:").w400.black),
                    Expanded(
                      child:
                          AppText.sp14(
                            "₦${TextFormater.amount(deliveryFee)}",
                          ).w400.black.endAlign,
                    ),
                  ],
                ),
                24.verticalSpace,
                Row(
                  children: [
                    Expanded(child: AppText.sp14("Total").w400.black),
                    Expanded(
                      child:
                          AppText.sp14(
                            "₦${TextFormater.amount(total)}",
                          ).w800.black.endAlign,
                    ),
                  ],
                ),
              ],
            ),
          ),
          20.verticalSpace,
          AppButton.primary(text: "PROCEED TO CHECKOUT", onTap: onProceed),
        ],
      ),
    );
  }
}
