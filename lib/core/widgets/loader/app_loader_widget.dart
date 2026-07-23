import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoaderWidget extends StatelessWidget {
  const AppLoaderWidget({super.key, this.iconColor});
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return SpinKitFoldingCube(
      color: iconColor ?? context.theme.colorScheme.onSurface,
      size: 50.0.w,
      duration: const Duration(milliseconds: 1000),
    );
  }
}
