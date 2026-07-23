import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/features/profile/presentation/pages/order_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaymentPage extends StatelessWidget {
  final String url;

  const PaymentPage({super.key, required this.url});

  static Future<void> start(BuildContext context, String url) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentPage(url: url)),
    );
    // AppFunctions.showOrderConfirmation(
    //   context,
    //   orderResponse: orderInfo,
    //   email: emailCntrl.text,
    // );
    // after payment page is done go to order summary page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return OrderHistoryPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: Center(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const CircleAvatar(
              backgroundColor: AppColor.primary,
              child: Icon(Icons.arrow_back_ios, color: AppColor.white),
            ),
          ),
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(url)),
        onLoadStart: (controller, url) {
          print(url);
        },
        onLoadStop: (controller, url) {
          print(url);
          if (url?.path == 'blank') {
            Navigator.pop(context, true);
          }
        },
        onCloseWindow: (controller) {
          print('closeWindow');
        },
        onNavigationResponse: (controller, response) async {
          print(response);
          return null;
        },
      ),
    );
  }
}
