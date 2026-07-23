import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';

class DeliveryDatasource {
  final RestService _client = RestService(baseUrl: AppUtils.baseUrl);

  Future<bool> setLabAvailability(
    int labId,
    List<Map<String, dynamic>> hoursList,
  ) async {
    final response = await _client.post(
      path: 'lab/$labId/availability',
      data: hoursList as dynamic,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? true;
  }
}
