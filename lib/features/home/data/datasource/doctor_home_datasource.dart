import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/home/data/models/doctor_dashboard.dart';

class DoctorHomeDatasource {
  final _client = RestService(baseUrl: AppUtils.baseUrl);

  Future<DoctorDashboard> getDashboard(int userId) async {
    final response = await _client.get(path: 'doctor/DoctorDashboard/$userId');

    if (response.hasError) throw response.error;
    return DoctorDashboard.fromJson(response.data!['data']);
  }
}
