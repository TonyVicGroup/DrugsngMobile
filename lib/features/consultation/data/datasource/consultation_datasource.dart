import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/auth/data/datasource/user_preference.dart';
import 'package:drugs_ng/features/consultation/data/models/consult_service.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_data.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_details.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_home_data.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_parameters.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor.dart';
import 'package:either_dart/either.dart';

class ConsultationDatasource {
  final RestService _client = RestService(baseUrl: AppUtils.baseUrl);

  Future<void> addConsultation(ConsultationData data) async {
    final dataMap = data.tojson();
    final userId = UserPreference.getUser().accountModel!.userId;
    dataMap["userId"] = userId;
    final response = await _client.post(
      path: 'consultation-schedule',
      data: dataMap,
    );
    if (response.hasError) throw ApiError(message: response.error.message);
  }

  Future<List<ConsultationDetails>> getConsultations(
    ConsultationParameters parameters,
  ) async {
    final userId = UserPreference.getUser().accountModel!.userId;
    final response = await _client.get(
      path: 'consultation-schedule/patient/$userId',
      params: parameters.toMap(),
    );
    if (response.hasError) throw ApiError(message: response.error.message);
    final data = response.data!['data'] as List;
    List<ConsultationDetails> consultations =
        data.map((d) => ConsultationDetails.fromJson(d)).toList();
    return consultations;
  }

  Future<ConsultationHomeData> getHomeData() async {
    final [docResponse, consultResponse] = await Future.wait([
      _client.get(path: 'doctor'),
      _client.get(path: 'consultation-offer'),
    ]);

    //doctors
    if (docResponse.hasError)
      throw ApiError(message: docResponse.error.message);
    final docData = docResponse.data!['data'] as List;
    List<Doctor> doctors = docData.map((e) => Doctor.fromJson(e)).toList();

    //consult offers
    if (consultResponse.hasError)
      throw ApiError(message: consultResponse.error.message);
    final consultData = consultResponse.data!['data'] as List;
    List<ConsultService> consultService =
        consultData.map((e) => ConsultService.fromJson(e)).toList();

    final data = ConsultationHomeData(
      doctors: doctors,
      service: consultService,
    );
    return data;
  }
}
