import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';

class HealthRecordDatasource {
  final RestService _client = RestService(baseUrl: AppUtils.baseUrl);

  // ==========================================
  // HEALTH RECORD ENDPOINTS
  // ==========================================

  /// POST /api/v1/health-record/user/{userId}
  /// Creates a new health record for a user.
  Future<dynamic> createHealthRecord(
    int userId,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.post(
      path: 'health-record/user/$userId',
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// PUT /api/v1/health-record/{id}
  /// Updates an existing health record by ID.
  Future<dynamic> updateHealthRecord(
    int id,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.put(
      path: 'health-record/$id',
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// DELETE /api/v1/health-record/{id}
  /// Deletes a health record by ID.
  Future<dynamic> deleteHealthRecord(int id) async {
    final response = await _client.delete(path: 'health-record/$id');
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/health-record/{id}
  /// Retrieves a health record by ID.
  Future<dynamic> getHealthRecordById(int id) async {
    final response = await _client.get(path: 'health-record/$id');
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/health-record/user/{userId}/records
  /// Retrieves paginated health records for a specific user.
  Future<dynamic> getUserHealthRecords(
    int userId, {
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
      path: 'health-record/user/$userId/records',
      params: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/health-record/records
  /// Retrieves paginated health records across all users.
  Future<dynamic> getAllHealthRecords({
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
      path: 'health-record/records',
      params: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  // ==========================================
  // HEALTH RECORD COMPLAINT ENDPOINTS
  // ==========================================

  /// POST /api/v1/health-record/{id}/complaint
  /// Adds a new complaint to a health record.
  Future<dynamic> addComplaintToRecord(
    int recordId,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.post(
      path: 'health-record/$recordId/complaint',
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// PUT /api/v1/health-record/complaint/{id}
  /// Updates a health record complaint by complaint ID.
  Future<dynamic> updateComplaint(
    int complaintId,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.put(
      path: 'health-record/complaint/$complaintId',
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// DELETE /api/v1/health-record/complaint/{id}
  /// Deletes a health record complaint by complaint ID.
  Future<dynamic> deleteComplaint(int complaintId) async {
    final response = await _client.delete(
      path: 'health-record/complaint/$complaintId',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/health-record/complaint/{id}
  /// Retrieves a health record complaint by complaint ID.
  Future<dynamic> getComplaintById(int complaintId) async {
    final response = await _client.get(
      path: 'health-record/complaint/$complaintId',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/health-record/{id}/complaints
  /// Retrieves all complaints for a specific health record ID.
  Future<dynamic> getRecordComplaints(
    int recordId, {
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
      path: 'health-record/$recordId/complaints',
      params: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }
}
