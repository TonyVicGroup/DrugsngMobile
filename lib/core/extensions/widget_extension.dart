import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  InkWell clickable(void Function()? onTap) => InkWell(
        onTap: onTap,
        child: this,
      );
}
