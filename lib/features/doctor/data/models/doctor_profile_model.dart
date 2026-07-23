import 'package:equatable/equatable.dart';

class DoctorProfileModel extends Equatable {
  const DoctorProfileModel({
    required this.id,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.dateOfBirth,
    required this.phone,
    required this.workPlace,
    required this.about,
    required this.location,
    required this.yearsOfExp,
    required this.patients,
    required this.profileImage,
    required this.ninDocumentUrl,
    required this.licenseDocumentUrl,
    required this.specializations,
    required this.availabilities,
  });
  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    return DoctorProfileModel(
      id: json['id'] as String,
      lastName: json['lastName'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      dateOfBirth: DateTime.parse(json['dob'] as String),
      phone: json['phone'] as String,
      workPlace: json['workPlace'] as String,
      about: json['about'] as String,
      location: json['location'] as String,
      yearsOfExp: json['yearsOfExp'] as int,
      patients: json['patients'] as int,
      profileImage: json['profileImage'] as String,
      ninDocumentUrl: json['ninDocumentUrl'] as String,
      licenseDocumentUrl: json['licenseDocumentUrl'] as String,
      specializations:
          (json['specializations'] as List<dynamic>)
              .map(
                (e) => SpecializationModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      availabilities:
          (json['availabilities'] as List<dynamic>)
              .map((e) => AvailabilityModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  final String id;
  final String lastName;
  final String fullName;
  final String email;
  final DateTime dateOfBirth;
  final String phone;
  final String workPlace;
  final String about;
  final String location;
  final int yearsOfExp;
  final int patients;
  final String profileImage;
  final String ninDocumentUrl;
  final String licenseDocumentUrl;
  final List<SpecializationModel> specializations;
  final List<AvailabilityModel> availabilities;

  @override
  List<Object?> get props => [
    id,
    lastName,
    fullName,
    email,
    dateOfBirth,
    phone,
    workPlace,
    about,
    location,
    yearsOfExp,
    patients,
    profileImage,
    ninDocumentUrl,
    licenseDocumentUrl,
    specializations,
    availabilities,
  ];
}

class SpecializationModel extends Equatable {
  const SpecializationModel({required this.id, required this.specialization});

  factory SpecializationModel.fromJson(Map<String, dynamic> json) {
    return SpecializationModel(
      id: json['id'] as String,
      specialization: json['specialization'] as String,
    );
  }
  final String id;
  final String specialization;

  @override
  List<Object?> get props => [id, specialization];
}

class AvailabilityModel extends Equatable {
  const AvailabilityModel({required this.dayOfWeek, required this.timeSlots});

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) {
    return AvailabilityModel(
      dayOfWeek: json['dayOfWeek'] as String,
      timeSlots:
          (json['timeSlots'] as List<dynamic>)
              .map((e) => TimeSlotModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  final String dayOfWeek;
  final List<TimeSlotModel> timeSlots;

  @override
  List<Object?> get props => [dayOfWeek, timeSlots];
}

class TimeSlotModel extends Equatable {
  const TimeSlotModel({
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
  });

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    return TimeSlotModel(
      startTime: SingleTimeSlot.fromJson(
        json['startTime'] as Map<String, dynamic>,
      ),
      endTime: SingleTimeSlot.fromJson(json['endTime'] as Map<String, dynamic>),
      isAvailable: json['isAvailable'] as bool,
    );
  }

  final SingleTimeSlot startTime;
  final SingleTimeSlot endTime;
  final bool isAvailable;

  @override
  List<Object?> get props => [startTime, endTime, isAvailable];
}

class SingleTimeSlot extends Equatable {
  const SingleTimeSlot({
    required this.ticks,
    required this.days,
    required this.hours,
    required this.milliseconds,
    required this.microseconds,
    required this.nanoseconds,
    required this.minutes,
    required this.seconds,
    required this.totalDays,
    required this.totalHours,
    required this.totalMilliseconds,
    required this.totalMicroseconds,
    required this.totalNanoseconds,
    required this.totalMinutes,
    required this.totalSeconds,
  });

  factory SingleTimeSlot.fromJson(Map<String, dynamic> json) {
    return SingleTimeSlot(
      ticks: json['ticks'] as int,
      days: json['days'] as int,
      hours: json['hours'] as int,
      milliseconds: json['milliseconds'] as int,
      microseconds: json['microseconds'] as int,
      nanoseconds: json['nanoseconds'] as int,
      minutes: json['minutes'] as int,
      seconds: json['seconds'] as int,
      totalDays: json['totalDays'] as int,
      totalHours: json['totalHours'] as int,
      totalMilliseconds: json['totalMilliseconds'] as int,
      totalMicroseconds: json['totalMicroseconds'] as int,
      totalNanoseconds: json['totalNanoseconds'] as int,
      totalMinutes: json['totalMinutes'] as int,
      totalSeconds: json['totalSeconds'] as int,
    );
  }

  final int ticks;
  final int days;
  final int hours;
  final int milliseconds;
  final int microseconds;
  final int nanoseconds;
  final int minutes;
  final int seconds;
  final int totalDays;
  final int totalHours;
  final int totalMilliseconds;
  final int totalMicroseconds;
  final int totalNanoseconds;
  final int totalMinutes;
  final int totalSeconds;

  @override
  List<Object?> get props => [
    ticks,
    days,
    hours,
    milliseconds,
    microseconds,
    nanoseconds,
    minutes,
    seconds,
    totalDays,
    totalHours,
    totalMilliseconds,
    totalMicroseconds,
    totalNanoseconds,
    totalMinutes,
    totalSeconds,
  ];
}
