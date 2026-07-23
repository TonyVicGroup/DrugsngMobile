import 'package:dio/dio.dart';
import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';

class LabDatasource {
  final RestService _client = RestService(baseUrl: AppUtils.baseUrl);

  // ==========================================
  // LAB AVAILABILITY ENDPOINTS
  // ==========================================

  /// POST /api/v1/lab/{labId}/availability
  /// Sets operating hours / availability for a lab.
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

  /// GET /api/v1/lab/{labId}/availability
  /// Gets operating hours / availability for a lab.
  Future<dynamic> getLabAvailability(int labId) async {
    final response = await _client.get(path: 'lab/$labId/availability');
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// POST /api/v1/lab/{labId}/block-date
  /// Blocks a specific date for a lab.
  Future<bool> blockLabDate(int labId, Map<String, dynamic> data) async {
    final response = await _client.post(
      path: 'lab/$labId/block-date',
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? true;
  }

  // ==========================================
  // LAB BOOKING ENDPOINTS
  // ==========================================

  /// GET /api/v1/lab-booking/estimate-home-collection
  /// Estimates home sample collection fee based on user location.
  Future<dynamic> estimateHomeCollectionFee({
    int? labId,
    double? userLat,
    double? userLng,
  }) async {
    final params = <String, dynamic>{
      if (labId != null) 'labId': labId,
      if (userLat != null) 'userLat': userLat,
      if (userLng != null) 'userLng': userLng,
    };
    final response = await _client.get(
      path: 'lab-booking/estimate-home-collection',
      params: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// POST /api/v1/lab-booking
  /// Creates a new lab booking.
  Future<dynamic> createLabBooking(Map<String, dynamic> data) async {
    final response = await _client.post(path: 'lab-booking', data: data);
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/lab-booking/{id}
  /// Retrieves details for a specific lab booking by ID.
  Future<dynamic> getLabBookingById(int id) async {
    final response = await _client.get(path: 'lab-booking/$id');
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/lab-booking/patient/{userId}
  /// Gets paginated lab bookings for a specific patient.
  Future<dynamic> getPatientLabBookings(
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
      path: 'lab-booking/patient/$userId',
      params: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/lab-booking/lab/{labId}
  /// Gets paginated lab bookings for a specific lab.
  Future<dynamic> getLabBookingsForLab(
    int labId, {
    String? status,
    String? fromDate,
    String? toDate,
    String? searchTerm,
    int? pageNumber,
    int? pageSize,
    bool? pendingRequest,
  }) async {
    final params = <String, dynamic>{
      if (status != null && status.isNotEmpty) 'Status': status,
      if (fromDate != null && fromDate.isNotEmpty) 'FromDate': fromDate,
      if (toDate != null && toDate.isNotEmpty) 'ToDate': toDate,
      if (searchTerm != null && searchTerm.isNotEmpty) 'SearchTerm': searchTerm,
      if (pageNumber != null) 'PageNumber': pageNumber,
      if (pageSize != null) 'PageSize': pageSize,
      if (pendingRequest != null) 'PendingRequest': pendingRequest,
    };
    final response = await _client.get(
      path: 'lab-booking/lab/$labId',
      params: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// PUT /api/v1/lab-booking/{id}/status
  /// Updates status of a lab booking.
  Future<dynamic> updateLabBookingStatus(
    int id,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.put(
      path: 'lab-booking/$id/status',
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// POST /api/v1/lab-booking/{id}/assign-agent
  /// Assigns a sample collection agent to a lab booking.
  Future<dynamic> assignCollectionAgent(
    int id,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.post(
      path: 'lab-booking/$id/assign-agent',
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// PUT /api/v1/lab-booking/{id}/cancel
  /// Cancels a lab booking.
  Future<bool> cancelLabBooking(int id, Map<String, dynamic> data) async {
    final response = await _client.put(
      path: 'lab-booking/$id/cancel',
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? true;
  }

  /// GET /api/v1/lab-booking/{id}/status-history
  /// Gets status history of a lab booking.
  Future<dynamic> getLabBookingStatusHistory(int id) async {
    final response = await _client.get(path: 'lab-booking/$id/status-history');
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/lab-booking/lab/{labId}/available-slots
  /// Retrieves available time slots for a lab on a given date.
  Future<dynamic> getAvailableSlots(int labId, {String? date}) async {
    final params = <String, dynamic>{
      if (date != null && date.isNotEmpty) 'date': date,
    };
    final response = await _client.get(
      path: 'lab-booking/lab/$labId/available-slots',
      params: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/lab-booking/{id}/package-items
  /// Retrieves package items included in a lab booking.
  Future<dynamic> getLabBookingPackageItems(int id) async {
    final response = await _client.get(path: 'lab-booking/$id/package-items');
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  // ==========================================
  // LAB DASHBOARD & AGENTS ENDPOINTS
  // ==========================================

  /// GET /api/v1/lab/{labId}/dashboard
  /// Gets dashboard metrics for a lab.
  Future<dynamic> getLabDashboard(int labId) async {
    final response = await _client.get(path: 'lab/$labId/dashboard');
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/lab/{labId}/agents
  /// Gets list of collection agents for a lab.
  Future<dynamic> getLabAgents(int labId) async {
    final response = await _client.get(path: 'lab/$labId/agents');
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// POST /api/v1/lab/{labId}/agents
  /// Adds a new collection agent for a lab.
  Future<dynamic> createLabAgent(int labId, Map<String, dynamic> data) async {
    final response = await _client.post(path: 'lab/$labId/agents', data: data);
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// PUT /api/v1/lab/agents/{agentId}
  /// Updates a collection agent's details.
  Future<dynamic> updateLabAgent(
    int agentId,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.put(
      path: 'lab/agents/$agentId',
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// DELETE /api/v1/lab/agents/{agentId}
  /// Deletes a collection agent.
  Future<bool> deleteLabAgent(int agentId) async {
    final response = await _client.delete(path: 'lab/agents/$agentId');
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? true;
  }

  // ==========================================
  // LABOURATORY MANAGEMENT ENDPOINTS
  // ==========================================

  /// POST /api/v1/labouratory
  /// Creates a new labouratory profile using multipart form data.
  Future<dynamic> createLabouratory({
    required String name,
    required String phoneNumber,
    required String address,
    dynamic image,
  }) async {
    final formData = FormData.fromMap({
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Address': address,
    });

    if (image != null) {
      if (image is MultipartFile) {
        formData.files.add(MapEntry('Image', image));
      } else if (image is String) {
        formData.files.add(
          MapEntry('Image', await MultipartFile.fromFile(image)),
        );
      }
    }

    final response = await _client.postFormData(
      path: 'labouratory',
      data: formData,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// POST /api/v1/labouratory/id/add-test
  /// Adds a test to a labouratory.
  Future<bool> addTestToLabouratory({
    int? labouratoryId,
    required Map<String, dynamic> data,
  }) async {
    final params = <String, dynamic>{
      if (labouratoryId != null) 'labouratoryId': labouratoryId,
    };
    final response = await _client.post(
      path: 'labouratory/id/add-test',
      queryParameters: params,
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? true;
  }

  /// POST /api/v1/labouratory/id/remove-test
  /// Removes a test from a labouratory.
  Future<bool> removeTestFromLabouratory({
    int? labouratoryId,
    required Map<String, dynamic> data,
  }) async {
    final params = <String, dynamic>{
      if (labouratoryId != null) 'labouratoryId': labouratoryId,
    };
    final response = await _client.post(
      path: 'labouratory/id/remove-test',
      queryParameters: params,
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? true;
  }

  /// PUT /api/v1/labouratory/{id}
  /// Updates a labouratory profile using multipart form data.
  Future<dynamic> updateLabouratory(
    int id, {
    String? name,
    String? phoneNumber,
    String? address,
    dynamic image,
  }) async {
    final formData = FormData.fromMap({
      if (name != null) 'Name': name,
      if (phoneNumber != null) 'PhoneNumber': phoneNumber,
      if (address != null) 'Address': address,
    });

    if (image != null) {
      if (image is MultipartFile) {
        formData.files.add(MapEntry('Image', image));
      } else if (image is String) {
        formData.files.add(
          MapEntry('Image', await MultipartFile.fromFile(image)),
        );
      }
    }

    final response = await _client.putFormData(
      path: 'labouratory/$id',
      data: formData,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// DELETE /api/v1/labouratory/{id}
  /// Deletes a labouratory profile.
  Future<bool> deleteLabouratory(int id) async {
    final response = await _client.delete(path: 'labouratory/$id');
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? true;
  }

  /// GET /api/v1/labouratory/{id}
  /// Gets details of a labouratory by ID.
  Future<dynamic> getLabouratoryById(int id) async {
    final response = await _client.get(path: 'labouratory/$id');
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/labouratory/test/{testId}
  /// Gets laboratories offering a specific test ID.
  Future<dynamic> getLabsByTest(int testId) async {
    final response = await _client.get(path: 'labouratory/test/$testId');
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/labouratory/labouratories
  /// Gets list/paginated labouratories with optional filters.
  Future<dynamic> getLabouratories({
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
      path: 'labouratory/labouratories',
      params: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/labouratory/nearby
  /// Gets nearby laboratories based on geolocation coordinates.
  Future<dynamic> getNearbyLabouratories({
    double? lat,
    double? lng,
    double? radiusKm,
    String? searchTerm,
    String? status,
    int? pageNumber,
    int? pageSize,
    bool? pendingRequest,
  }) async {
    final params = <String, dynamic>{
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (radiusKm != null) 'radiusKm': radiusKm,
      if (searchTerm != null && searchTerm.isNotEmpty) 'SearchTerm': searchTerm,
      if (status != null && status.isNotEmpty) 'Status': status,
      if (pageNumber != null) 'PageNumber': pageNumber,
      if (pageSize != null) 'PageSize': pageSize,
      if (pendingRequest != null) 'PendingRequest': pendingRequest,
    };
    final response = await _client.get(
      path: 'labouratory/nearby',
      params: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// PUT /api/v1/labouratory/{labId}/home-collection-settings
  /// Updates home collection settings for a lab.
  Future<bool> updateHomeCollectionSettings(
    int labId,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.put(
      path: 'labouratory/$labId/home-collection-settings',
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? true;
  }

  /// PUT /api/v1/labouratory/{labId}/approve
  /// Approves a labouratory account.
  Future<bool> approveLabouratory(int labId, Map<String, dynamic> data) async {
    final response = await _client.put(
      path: 'labouratory/$labId/approve',
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? true;
  }

  /// GET /api/v1/labouratory/package/{packageId}/test-allocations
  /// Gets test allocations for a wellness package.
  Future<dynamic> getWellnessPackageTestAllocations(int packageId) async {
    final response = await _client.get(
      path: 'labouratory/package/$packageId/test-allocations',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// POST /api/v1/labouratory/package/{packageId}/test-allocations
  /// Sets test allocations for a wellness package.
  Future<bool> setWellnessPackageTestAllocation(
    int packageId,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.post(
      path: 'labouratory/package/$packageId/test-allocations',
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? true;
  }

  // ==========================================
  // LAB TEST RESULT ENDPOINTS
  // ==========================================

  /// POST /api/v1/lab-booking/{bookingId}/results
  /// Uploads lab test result file for a booking using multipart form data.
  Future<dynamic> uploadLabResult(
    int bookingId, {
    required dynamic file,
    String? notes,
    int? labBookingPackageItemId,
  }) async {
    final formData = FormData.fromMap({
      if (notes != null) 'Notes': notes,
      if (labBookingPackageItemId != null)
        'LabBookingPackageItemId': labBookingPackageItemId,
    });

    if (file is MultipartFile) {
      formData.files.add(MapEntry('File', file));
    } else if (file is String) {
      formData.files.add(MapEntry('File', await MultipartFile.fromFile(file)));
    }

    final response = await _client.postFormData(
      path: 'lab-booking/$bookingId/results',
      data: formData,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/v1/lab-booking/{bookingId}/results
  /// Gets test results for a booking.
  Future<dynamic> getLabResults(int bookingId) async {
    final response = await _client.get(path: 'lab-booking/$bookingId/results');
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// DELETE /api/v1/lab-booking/results/{id}
  /// Deletes a lab test result.
  Future<bool> deleteLabResult(int id) async {
    final response = await _client.delete(path: 'lab-booking/results/$id');
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? true;
  }
}
