// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

import 'package:drugs_ng/features/consultation/data/models/doctor_details.dart';

class ConsultationData {
  final String fullName;
  final String phoneNumber;
  final String gender;
  final DateTime dateOfBirth;
  final String currentMedications;
  final String allergies;
  final String previousMedicalConditions;
  final String descriptionOfSymptoms;
  final DoctorDetails doctor;
  final String consultationType;
  final String insuranceProvider;
  final bool shareHistory;
  final DateTime scheduledDate;

  ConsultationData({
    required this.fullName,
    required this.phoneNumber,
    required this.gender,
    required this.dateOfBirth,
    required this.currentMedications,
    required this.allergies,
    required this.previousMedicalConditions,
    required this.descriptionOfSymptoms,
    required this.doctor,
    required this.consultationType,
    required this.insuranceProvider,
    required this.shareHistory,
    required this.scheduledDate,
  });

  Map<String, dynamic> tojson() {
    final dateFormat = DateFormat('yyy-MM-dd');
    final timeFormat = DateFormat('HH:mm');
    return {
      "userId": 20,
      "doctorId": doctor.id,
      "name": fullName,
      "phoneNumber": phoneNumber,
      "dob": dateFormat.format(dateOfBirth),
      "gender": gender,
      "allergies": allergies,
      "previousMedicalConditions": previousMedicalConditions,
      "symptomsAndConcerns": descriptionOfSymptoms,
      "currentMedication": currentMedications,
      "insuranceProvider": insuranceProvider,
      "isShareHistory": shareHistory,
      "scheduledDate": dateFormat.format(scheduledDate),
      "consultationType": consultationType,
      "scheduledStartTime": timeFormat.format(scheduledDate),
      "scheduledEndTime": timeFormat.format(
        scheduledDate.add(const Duration(hours: 1)),
      ),
    };
  }

  @override
  String toString() {
    return 'ConsultationData(fullName: $fullName, phoneNumber: $phoneNumber, gender: $gender, dateOfBirth: $dateOfBirth, currentMedications: $currentMedications, allergies: $allergies, previousMedicalConditions: $previousMedicalConditions, descriptionOfSymptoms: $descriptionOfSymptoms, doctor: $doctor, consultationType: $consultationType, insuranceProvider: $insuranceProvider, shareHistory: $shareHistory, scheduledDate: $scheduledDate)';
  }
}
