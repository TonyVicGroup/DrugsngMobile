import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  InkWell clickable(void Function()? onTap) {
    return InkWell(onTap: onTap, child: this);
  }
}
