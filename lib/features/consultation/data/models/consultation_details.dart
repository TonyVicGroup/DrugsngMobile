import 'package:equatable/equatable.dart';

class ConsultationDetails extends Equatable {
  static const String _idKey = "id";
  static const String _symptomsAndConcernsKey = "symptomsAndConcerns";
  static const String _currentMedicationKey = "currentMedication";
  static const String _allergiesKey = "allergies";
  static const String _previousMedicalConditionsKey =
      "previousMedicalConditions";
  static const String _insuranceProviderKey = "insuranceProvider";
  static const String _scheduledDateKey = "scheduledDate";
  static const String _patientRecordIdKey = "patientRecordId";
  static const String _patientNameKey = "patientName";
  static const String _consultationTypeKey = "consultationType";
  static const String _statusKey = "status";
  static const String _isShareHistoryKey = "isShareHistory";
  static const String _doctorIdKey = "doctorId";
  static const String _doctorNameKey = "doctorName";

  final int id;
  final String symptomsAndConcerns;
  final String currentMedication;
  final String allergies;
  final String previousMedicalConditions;
  final String insuranceProvider;
  final DateTime scheduledDate;
  final int patientRecordId;
  final String patientName;
  final String consultationType;
  final String status;
  final bool isShareHistory;
  final int doctorId;
  final String doctorName;

  const ConsultationDetails({
    required this.id,
    required this.symptomsAndConcerns,
    required this.currentMedication,
    required this.allergies,
    required this.previousMedicalConditions,
    required this.insuranceProvider,
    required this.scheduledDate,
    required this.patientRecordId,
    required this.patientName,
    required this.consultationType,
    required this.status,
    required this.isShareHistory,
    required this.doctorId,
    required this.doctorName,
  });

  factory ConsultationDetails.fromJson(Map json) {
    return ConsultationDetails(
      id: json[_idKey] as int? ?? 0,
      symptomsAndConcerns: json[_symptomsAndConcernsKey] as String? ?? '',
      currentMedication: json[_currentMedicationKey] as String? ?? '',
      allergies: json[_allergiesKey] as String? ?? '',
      previousMedicalConditions:
          json[_previousMedicalConditionsKey] as String? ?? '',
      insuranceProvider: json[_insuranceProviderKey] as String? ?? '',
      scheduledDate:
          DateTime.tryParse(json[_scheduledDateKey] as String? ?? '') ??
              DateTime(1000),
      patientRecordId: json[_patientRecordIdKey] as int? ?? 0,
      patientName: json[_patientNameKey] as String? ?? '',
      consultationType: json[_consultationTypeKey] as String? ?? '',
      status: json[_statusKey] as String? ?? '',
      isShareHistory: json[_isShareHistoryKey] as bool? ?? false,
      doctorId: json[_doctorIdKey] as int? ?? 0,
      doctorName: json[_doctorNameKey] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        symptomsAndConcerns,
        currentMedication,
        allergies,
        previousMedicalConditions,
        insuranceProvider,
        scheduledDate,
        patientRecordId,
        patientName,
        consultationType,
        status,
        isShareHistory,
        doctorId,
        doctorName
      ];
}
