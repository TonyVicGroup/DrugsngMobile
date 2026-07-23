import 'package:drugs_ng/core/widgets/loader/app_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabLoaderWidget extends StatelessWidget {
  const TabLoaderWidget({this.color, super.key});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [SizedBox(height: 180.h), AppLoaderWidget(iconColor: color)],
    );
  }
}
