import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class SelectAccountPage extends StatelessWidget {
  const SelectAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorFFFFFF,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: AppText.sp18(
          'Select Account Type',
        ).w600.setColor(AppColor.color333333),
      ),
      body: Column(children: []),
    );
  }
}
