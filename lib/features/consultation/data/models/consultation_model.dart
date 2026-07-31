import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ConsultationMeetingType {
  inPerson,
  meetCall;

  String get label => switch (this) {
    inPerson => "In Person",
    meetCall => "Meet Call",
  };

  String get keyId => switch (this) {
    inPerson => "in_person",
    meetCall => "meet_call",
  };

  static ConsultationMeetingType fromKey(String keyId) {
    return switch (keyId) {
      "in_person" => inPerson,
      "meet_call" => meetCall,
      _ => inPerson,
    };
  }
}

enum ConsultationStatusEnum {
  upcoming,
  completed,
  cancelled;

  String get label => switch (this) {
    upcoming => "Upcoming",
    completed => "Completed",
    cancelled => "Cancelled",
  };

  String get keyId => switch (this) {
    upcoming => "upcoming",
    completed => "completed",
    cancelled => "cancelled",
  };

  static ConsultationStatusEnum fromKey(String keyId) {
    return switch (keyId) {
      "upcoming" => upcoming,
      "completed" => completed,
      "cancelled" => cancelled,
      _ => upcoming,
    };
  }

  Color get foregroundColor => switch (this) {
    upcoming => AppColor.colorFEF3C7,
    completed => AppColor.colorD1FAE5,
    cancelled => AppColor.colorFEE2E2,
  };

  Color get backgroundColor => switch (this) {
    upcoming => AppColor.color92400E,
    completed => AppColor.color065F46,
    cancelled => AppColor.color991B1B,
  };
}

class ConsultationModel extends Equatable {
  final String doctorName;
  final String doctorAvatar;
  final String doctorSpecialization;
  final String hospitalName;
  final DateTime date;
  final ConsultationMeetingType meetType;
  final ConsultationStatusEnum status;

  const ConsultationModel({
    required this.doctorName,
    required this.doctorAvatar,
    required this.doctorSpecialization,
    required this.hospitalName,
    required this.date,
    required this.meetType,
    required this.status,
  });

  @override
  List<Object?> get props => [
    doctorName,
    doctorAvatar,
    doctorSpecialization,
    hospitalName,
    date,
    meetType,
    status,
  ];

  static List<ConsultationModel> mockData = [
    ConsultationModel(
      doctorName: "Dr. Emmanuel Okonkwo",
      doctorAvatar: "",
      doctorSpecialization: "Dermatologist",
      hospitalName: "Health Plus Pharmacy and Surgery",
      date: DateTime.now(),
      meetType: ConsultationMeetingType.inPerson,
      status: ConsultationStatusEnum.upcoming,
    ),
    ConsultationModel(
      doctorName: "Dr. Emmanuel Okonkwo",
      doctorAvatar: "",
      doctorSpecialization: "Dermatologist",
      hospitalName: "Health Plus Pharmacy and Surgery",
      date: DateTime.now(),
      meetType: ConsultationMeetingType.inPerson,
      status: ConsultationStatusEnum.upcoming,
    ),
    ConsultationModel(
      doctorName: "Dr. Emmanuel Okonkwo",
      doctorAvatar: "",
      doctorSpecialization: "Dermatologist",
      hospitalName: "Health Plus Pharmacy and Surgery",
      date: DateTime.now(),
      meetType: ConsultationMeetingType.inPerson,
      status: ConsultationStatusEnum.completed,
    ),
    ConsultationModel(
      doctorName: "Dr. Emmanuel Okonkwo",
      doctorAvatar: "",
      doctorSpecialization: "Dermatologist",
      hospitalName: "Health Plus Pharmacy and Surgery",
      date: DateTime.now(),
      meetType: ConsultationMeetingType.inPerson,
      status: ConsultationStatusEnum.cancelled,
    ),
  ];
}
