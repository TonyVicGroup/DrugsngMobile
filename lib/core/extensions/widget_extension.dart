import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  InkWell clickable(
    void Function()? onTap, {
    BorderRadius? radius,
  }) {
    return InkWell(onTap: onTap, borderRadius: radius, child: this);
  }

  Widget padAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Widget padSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget padOnly({
    double left = 0,
    double right = 0,
    double bottom = 0,
    double top = 0,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: left,
          right: right,
          bottom: bottom,
          top: top,
        ),
        child: this,
      );
}
