import 'package:equatable/equatable.dart';

class DoctorDashboard extends Equatable {
  final int fulfilledConsultationCount;
  final int upcomingAppointmentsCount;
  final int totalEarnings;
  final List upcomingAppointments;
  final List recentConsultations;

  const DoctorDashboard(
      {required this.fulfilledConsultationCount,
      required this.upcomingAppointmentsCount,
      required this.totalEarnings,
      required this.upcomingAppointments,
      required this.recentConsultations});

  factory DoctorDashboard.fromJson(Map<String, dynamic> json) {
    return DoctorDashboard(
      fulfilledConsultationCount:
          (json["fulfilledConsultationCount"] as num? ?? 0).toInt(),
      upcomingAppointmentsCount:
          (json["upcomingAppointmentsCount"] as num? ?? 0).toInt(),
      totalEarnings: (json["totalEarnings"] as num? ?? 0).toInt(),
      upcomingAppointments: json["upcomingAppointments"] as List? ?? [],
      recentConsultations: json["recentConsultations"] as List? ?? [],
    );
  }

  @override
  List<Object?> get props => [
        fulfilledConsultationCount,
        upcomingAppointmentsCount,
        totalEarnings,
        upcomingAppointments,
        recentConsultations
      ];
}
