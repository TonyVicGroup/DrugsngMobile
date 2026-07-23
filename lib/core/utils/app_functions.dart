import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/auth/presentation/pages/confirmation_page.dart';
import 'package:drugs_ng/features/checkout/data/models/order_response.dart';
import 'package:flutter/material.dart';

class AppFunctions {
  static void showOrderConfirmation(
    BuildContext context, {
    required OrderResponse orderResponse,
    required String email,
  }) {
    final nav = Navigator.of(context);
    nav.pushReplacement(
      AppUtils.transition(
        ConfirmationPage(
          title: "Order Successful!",
          subtitle: "Your order ",
          buttonTextSpacing: 20,
          children: [
            TextSpan(
              text: orderResponse.orderReference,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColor.darkGrey,
              ),
            ),
            const TextSpan(
              text: " has been placed and we have sent an email to ",
            ),
            TextSpan(
              text: email,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColor.darkGrey,
              ),
            ),
            const TextSpan(text: " with your order confirmation and bill"),
          ],
          btnText: "Back to Shopping",
          onTap: () {
            nav.popUntil((route) => route.isFirst);
          },
        ),
      ),
    );
  }
}
