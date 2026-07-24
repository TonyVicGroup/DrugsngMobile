import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_back_button.dart';
import 'package:flutter/material.dart';

class CompleteDoctorVerificationSummaryPage extends StatelessWidget {
  const CompleteDoctorVerificationSummaryPage({super.key});

  static Route<dynamic> route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const CompleteDoctorVerificationSummaryPage(),
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorFFFFFF,
      appBar: AppBar(
        leading: Center(child: AppBackButton.grey(() => _goBack(context))),
        forceMaterialTransparency: true,
        title: AppText.sp18('Select Account'),
      ),
    );
  }

  void _goBack(BuildContext context) {
    context.pop();
  }
}
