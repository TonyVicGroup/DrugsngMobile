import 'package:drugs_ng/features/consultation/data/models/consult_service.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor.dart';
import 'package:equatable/equatable.dart';

class ConsultationHomeData extends Equatable {
  final List<Doctor> doctors;
  final List<ConsultService> service;

  const ConsultationHomeData({required this.doctors, required this.service});

  bool get isEmpty => doctors.isEmpty && service.isEmpty;

  factory ConsultationHomeData.initial() =>
      const ConsultationHomeData(doctors: [], service: []);

  @override
  List<Object?> get props => [doctors, service];
}
