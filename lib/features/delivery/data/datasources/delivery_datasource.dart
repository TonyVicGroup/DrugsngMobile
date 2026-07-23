import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';

class DeliveryDatasource {
  final RestService _client = RestService(baseUrl: AppUtils.baseUrl);

  /// POST /api/v1/dispatch/riders
  Future<dynamic> createDispatchRider(Map<String, dynamic> data) async {
    final response = await _client.post(path: 'dispatch/riders', data: data);
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/dispatch/riders
  Future<dynamic> getDispatchRiders({
    String? state,
    String? city,
    bool? isAvailable,
    int? organisationId,
    String? searchTerm,
    String? status,
    int? pageNumber,
    int? pageSize,
    bool? pendingRequest,
  }) async {
    final params = <String, dynamic>{
      if (state != null && state.isNotEmpty) 'State': state,
      if (city != null && city.isNotEmpty) 'City': city,
      if (isAvailable != null) 'IsAvailable': isAvailable,
      if (organisationId != null) 'OrganisationId': organisationId,
      if (searchTerm != null && searchTerm.isNotEmpty) 'SearchTerm': searchTerm,
      if (status != null && status.isNotEmpty) 'Status': status,
      if (pageNumber != null) 'PageNumber': pageNumber,
      if (pageSize != null) 'PageSize': pageSize,
      if (pendingRequest != null) 'PendingRequest': pendingRequest,
    };

    final response = await _client.get(path: 'dispatch/riders', params: params);
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/dispatch/riders/{id}
  Future<dynamic> getDispatchRiderById(int id) async {
    final response = await _client.get(path: 'dispatch/riders/$id');
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// PUT /api/v1/dispatch/riders/{id}
  Future<dynamic> updateDispatchRider(int id, Map<String, dynamic> data) async {
    final response = await _client.put(path: 'dispatch/riders/$id', data: data);
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// DELETE /api/v1/dispatch/riders/{id}
  Future<bool> deleteDispatchRider(int id) async {
    final response = await _client.delete(path: 'dispatch/riders/$id');
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? true;
  }

  /// POST /api/v1/dispatch/riders/{riderId}/assign/{orderId}
  Future<dynamic> assignOrderToRider(int riderId, int orderId) async {
    final response = await _client.post(
      path: 'dispatch/riders/$riderId/assign/$orderId',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// PUT /api/v1/dispatch/orders/{orderId}/reassign/{newRiderId}
  Future<dynamic> reassignOrder(int orderId, int newRiderId) async {
    final response = await _client.put(
      path: 'dispatch/orders/$orderId/reassign/$newRiderId',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// POST /api/v1/dispatch/orders/{orderId}/complete
  Future<dynamic> completeOrder(int orderId, {String? otp}) async {
    final params = <String, dynamic>{
      if (otp != null && otp.isNotEmpty) 'otp': otp,
    };

    final response = await _client.post(
      path: 'dispatch/orders/$orderId/complete',
      queryParameters: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/dispatch/riders/{riderId}/orders
  Future<dynamic> getRiderOrders(
    int riderId, {
    String? searchTerm,
    String? status,
    int? pageNumber,
    int? pageSize,
    bool? pendingRequest,
  }) async {
    final params = <String, dynamic>{
      if (searchTerm != null && searchTerm.isNotEmpty) 'SearchTerm': searchTerm,
      if (status != null && status.isNotEmpty) 'Status': status,
      if (pageNumber != null) 'PageNumber': pageNumber,
      if (pageSize != null) 'PageSize': pageSize,
      if (pendingRequest != null) 'PendingRequest': pendingRequest,
    };

    final response = await _client.get(
      path: 'dispatch/riders/$riderId/orders',
      params: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// PUT /api/v1/dispatch/riders/{riderId}/location
  Future<bool> updateRiderLocation(
    int riderId,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.put(
      path: 'dispatch/riders/$riderId/location',
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? true;
  }

  /// GET /api/v1/dispatch/riders/{riderId}/location
  Future<dynamic> getRiderLocation(int riderId) async {
    final response = await _client.get(
      path: 'dispatch/riders/$riderId/location',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/dispatch/companies/{organisationId}/performance
  Future<dynamic> getCompanyPerformance(int organisationId) async {
    final response = await _client.get(
      path: 'dispatch/companies/$organisationId/performance',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }
}
