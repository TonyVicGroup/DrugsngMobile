import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DoctorDetails {
  static const _idKey = "id";
  static const _firstNameKey = "firstName";
  static const _lastNameKey = "lastName";
  static const _fullNameKey = "fullName";
  static const _emailKey = "email";
  static const _dobKey = "dob";
  static const _genderKey = "gender";
  static const _phoneKey = "phone";
  // static const _specialityKey = "speciality";
  static const _workPlaceKey = "workPlace";
  static const _aboutKey = "about";
  static const _locationKey = "location";
  static const _yearsOfExpKey = "yearsOfExp";
  static const _patientsKey = "patients";
  static const _profileImageKey = "profileImage";
  static const _specializationsKey = "specializations";
  static const _ninDocumentUrlKey = "ninDocumentUrl";
  static const _licenseDocumentUrlKey = "licenseDocumentUrl";
  static const _availabilitiesKey = "availabilities";

  final int id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final DateTime? dob;
  final String gender;
  final String phone;
  // final String speciality;
  final String workPlace;
  final String about;
  final String location;
  final int yearsOfExp;
  final int patients;
  final String? profileImage;
  final String ninDocumentUrl;
  final String licenseDocumentUrl;
  final List<String> specializations;
  final List<Availabilities> availabilities;

  DoctorDetails({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.dob,
    required this.gender,
    required this.phone,
    // required this.speciality,
    required this.workPlace,
    required this.about,
    required this.location,
    required this.yearsOfExp,
    required this.patients,
    required this.profileImage,
    required this.specializations,
    required this.ninDocumentUrl,
    required this.licenseDocumentUrl,
    required this.availabilities,
  });

  factory DoctorDetails.fromJson(Map json) {
    List<String> sList = (json[_specializationsKey] as List? ?? [])
        .map<String>((e) => e["specialization"])
        .toList();
    List<Availabilities> avail = (json[_availabilitiesKey] as List? ?? [])
        .map<Availabilities>((js) => Availabilities.fromJson(js))
        .toList();

    return DoctorDetails(
      id: json[_idKey],
      firstName: json[_firstNameKey] ?? '',
      lastName: json[_lastNameKey] ?? '',
      fullName: json[_fullNameKey] ?? '',
      email: json[_emailKey] ?? '',
      dob: DateTime.tryParse(json[_dobKey] as String? ?? ''),
      gender: json[_genderKey] ?? '',
      phone: json[_phoneKey] ?? '',
      // speciality: json[_specialityKey],
      workPlace: json[_workPlaceKey] ?? '',
      about: json[_aboutKey] ?? '',
      location: json[_locationKey] ?? '',
      yearsOfExp: json[_yearsOfExpKey],
      patients: json[_patientsKey],
      profileImage: json[_profileImageKey],
      licenseDocumentUrl: json[_licenseDocumentUrlKey] ?? '',
      ninDocumentUrl: json[_ninDocumentUrlKey] ?? '',
      specializations: sList,
      availabilities: avail,
    );
  }
}

class Availabilities extends Equatable {
  final String dayOfWeek;
  final List<TimeSlot> timeSlots;

  const Availabilities({required this.dayOfWeek, required this.timeSlots});

  factory Availabilities.fromJson(Map<String, dynamic> json) {
    return Availabilities(
      dayOfWeek: json['dayOfWeek'] as String? ?? '',
      timeSlots: (json['timeSlots'] as List? ?? [])
          .map((tSlot) => TimeSlot.fromJson(tSlot))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [dayOfWeek, timeSlots];
}

class TimeSlot extends Equatable {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final bool isAvailable;

  const TimeSlot(
      {required this.startTime,
      required this.endTime,
      required this.isAvailable});
  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      startTime: toTimeOfDay(json['startTime']),
      endTime: toTimeOfDay(json['endTime']),
      isAvailable: json['isAvailable'] as bool? ?? false,
    );
  }

  static TimeOfDay toTimeOfDay(String time) {
    final timeList = time.split(':');
    int hour = int.tryParse(timeList.first) ?? 0;
    int minute = int.tryParse(timeList[1]) ?? 0;
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  List<Object?> get props => [startTime, endTime, isAvailable];
}
