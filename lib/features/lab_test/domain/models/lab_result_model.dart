import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum LabResultStatusEnum {
  attention,
  normal,
  reviewed;

  Color get foregroundColor => switch (this) {
    attention => AppColor.colorFEF3C7,
    normal => AppColor.colorE6F2FC,
    reviewed => AppColor.colorD1FAE5,
  };
  Color get backgroundColor => switch (this) {
    attention => AppColor.color92400E,
    normal => AppColor.color0B8AE1,
    reviewed => AppColor.color065F46,
  };
  String get label => switch (this) {
    attention => 'ATTENTION',
    normal => 'NORMAL',
    reviewed => 'REVIEWED',
  };

  String get keyId => switch (this) {
    attention => 'attention',
    normal => 'normal',
    reviewed => 'reviewed',
  };

  static LabResultStatusEnum fromKey(String keyId) {
    return switch (keyId) {
      'attention' => attention,
      'normal' => normal,
      'reviewed' => reviewed,
      _ => attention,
    };
  }

  @override
  String toString() => label;
}

class LabResultModel extends Equatable {
  final String title;
  final DateTime date;
  final String labName;
  final LabResultStatusEnum status;

  const LabResultModel({
    required this.title,
    required this.date,
    required this.labName,
    required this.status,
  });

  @override
  List<Object?> get props => [title, date, labName, status];

  static List<LabResultModel> sampleData = [
    LabResultModel(
      title: "CBC",
      date: DateTime.now(),
      labName: "General Hospital",
      status: LabResultStatusEnum.attention,
    ),
    LabResultModel(
      title: "CBC",
      date: DateTime.now(),
      labName: "General Hospital",
      status: LabResultStatusEnum.normal,
    ),
    LabResultModel(
      title: "CBC",
      date: DateTime.now(),
      labName: "General Hospital",
      status: LabResultStatusEnum.reviewed,
    ),
    LabResultModel(
      title: "CBC",
      date: DateTime.now(),
      labName: "General Hospital",
      status: LabResultStatusEnum.attention,
    ),
    LabResultModel(
      title: "CBC",
      date: DateTime.now(),
      labName: "General Hospital",
      status: LabResultStatusEnum.normal,
    ),
    LabResultModel(
      title: "CBC",
      date: DateTime.now(),
      labName: "General Hospital",
      status: LabResultStatusEnum.reviewed,
    ),
    LabResultModel(
      title: "CBC",
      date: DateTime.now(),
      labName: "General Hospital",
      status: LabResultStatusEnum.attention,
    ),
    LabResultModel(
      title: "CBC",
      date: DateTime.now(),
      labName: "General Hospital",
      status: LabResultStatusEnum.normal,
    ),
    LabResultModel(
      title: "CBC",
      date: DateTime.now(),
      labName: "General Hospital",
      status: LabResultStatusEnum.reviewed,
    ),
  ];
}
