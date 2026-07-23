import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/widgets/loader/app_loader_widget.dart';
import 'package:flutter/material.dart';

class AppLoaderOverlay extends StatelessWidget {
  const AppLoaderOverlay({
    required this.child,
    required this.isLoading,
    this.iconColor,
    super.key,
  });
  final Widget child;
  final bool isLoading;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Stack(
        children: [
          child,
          if (isLoading)
            ColoredBox(
              color: context.theme.colorScheme.onSurface.withAlpha(100),
              child: Center(child: AppLoaderWidget(iconColor: iconColor)),
            ),
        ],
      ),
    );
  }
}
