import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:flutter/material.dart';

class VerifyListTileEntity {
  final String title;
  final String value;
  final String? svg;
  final Color color;

  VerifyListTileEntity({
    required this.title,
    required this.value,
    required this.svg,
    required this.color,
  });

  factory VerifyListTileEntity.blackText({
    required String title,
    required String value,
  }) {
    return VerifyListTileEntity(
      title: title,
      value: value,
      svg: null,
      color: AppColor.color111827,
    );
  }

  factory VerifyListTileEntity.blueText({
    required String title,
    required String value,
  }) {
    return VerifyListTileEntity(
      title: title,
      value: value,
      svg: null,
      color: AppColor.color0B8AE1,
    );
  }

  factory VerifyListTileEntity.blueIconText({
    required String title,
    required String svg,
    required String value,
  }) {
    return VerifyListTileEntity(
      title: title,
      value: value,
      svg: svg,
      color: AppColor.color0B8AE1,
    );
  }
}
