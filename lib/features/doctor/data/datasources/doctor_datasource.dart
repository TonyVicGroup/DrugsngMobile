import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor_details.dart';
import 'package:drugs_ng/features/doctor/data/models/create_doctor_request.dart';
import 'package:drugs_ng/features/doctor/data/models/create_doctor_response.dart';
import 'package:drugs_ng/features/doctor/data/models/doctor_profile_model.dart';
import 'package:drugs_ng/features/doctor/data/models/get_doctors_parameters.dart';
import 'package:drugs_ng/features/doctor/data/models/update_doctor_request.dart';
import 'package:drugs_ng/features/home/data/models/doctor_dashboard.dart';

class DoctorDatasource {
  final RestService _client = RestService(baseUrl: AppUtils.baseUrl);

  /// POST /api/v1/doctor
  /// Creates a doctor profile using multipart form data.
  Future<CreateDoctorResponse> createDoctor(CreateDoctorRequest request) async {
    final formData = await request.toFormData();
    final response = await _client.postFormData(path: 'doctor', data: formData);
    if (response.hasError) throw response.error;
    return CreateDoctorResponse.fromJson(
      response.data!['data'] as Map<String, dynamic>,
    );
  }

  /// GET /api/v1/doctor
  /// Retrieves a list of doctors based on query parameters.
  Future<List<Doctor>> getDoctors([GetDoctorsParameters? parameters]) async {
    final response = await _client.get(
      path: 'doctor',
      params: parameters?.toMap(),
    );
    if (response.hasError) throw response.error;
    final data = response.data!['data'] as List;
    return data.map((e) => Doctor.fromJson(e as Map<String, dynamic>)).toList();
  }

  /// PUT /api/v1/doctor/{id}
  /// Updates a doctor's profile by ID using multipart form data.
  Future<DoctorDetails> updateDoctor(
    int id,
    UpdateDoctorRequest request,
  ) async {
    final formData = await request.toFormData();
    final response = await _client.putFormData(
      path: 'doctor/$id',
      data: formData,
    );
    if (response.hasError) throw response.error;
    return DoctorDetails.fromJson(
      response.data!['data'] as Map<String, dynamic>,
    );
  }

  /// DELETE /api/v1/doctor/{id}
  /// Deletes a doctor record by ID.
  Future<bool> deleteDoctor(int id) async {
    final response = await _client.delete(path: 'doctor/$id');
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? true;
  }

  /// GET /api/v1/doctor/{id}
  /// Retrieves doctor details by ID.
  Future<DoctorProfileModel> getDoctorById(int id) async {
    final response = await _client.get(path: 'doctor/$id');
    if (response.hasError) throw response.error;
    return DoctorProfileModel.fromJson(
      response.data!['data'] as Map<String, dynamic>,
    );
  }

  /// POST /api/v1/doctor/verify/{doctorId}
  /// Verifies a doctor profile by doctor ID.
  Future<String> verifyDoctor(int doctorId) async {
    final response = await _client.post(path: 'doctor/verify/$doctorId');
    if (response.hasError) throw response.error;
    return (response.data!['data'] ??
            response.data!['responseMessage'] ??
            'Success')
        as String;
  }

  /// GET /api/v1/doctor/DoctorDashboard/{doctorId}
  /// Retrieves doctor dashboard info by doctor ID.
  Future<DoctorDashboard> getDoctorDashboard(int doctorId) async {
    final response = await _client.get(
      path: 'doctor/DoctorDashboard/$doctorId',
    );
    if (response.hasError) throw response.error;
    return DoctorDashboard.fromJson(
      response.data!['data'] as Map<String, dynamic>,
    );
  }
}
