import 'package:dio/dio.dart';
import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';

class PharmacyDatasource {
  final RestService _client = RestService(baseUrl: AppUtils.baseUrl);

  // ==========================================
  // PHARMACY METRICS & SALES ENDPOINTS
  // ==========================================

  /// GET /api/Pharmacy/GetPharmacyMetrics/{pharmacyId}
  /// Retrieves general metrics for a pharmacy.
  Future<dynamic> getPharmacyMetrics(int pharmacyId) async {
    final response = await _client.get(
      path: '../Pharmacy/GetPharmacyMetrics/$pharmacyId',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/Pharmacy/GetPharmacyTransactionMetrics/{pharmacyId}
  /// Retrieves transaction metrics for a pharmacy.
  Future<dynamic> getPharmacyTransactionMetrics(int pharmacyId) async {
    final response = await _client.get(
      path: '../Pharmacy/GetPharmacyTransactionMetrics/$pharmacyId',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/Pharmacy/GetPharmacySales/{pharmacyId}
  /// Retrieves recent sales for a pharmacy.
  Future<dynamic> getPharmacySales(int pharmacyId) async {
    final response = await _client.get(
      path: '../Pharmacy/GetPharmacySales/$pharmacyId',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/Pharmacy/GetPharmacyBestSellingProducts/{pharmacyId}
  /// Retrieves best-selling products for a pharmacy.
  Future<dynamic> getPharmacyBestSellingProducts(int pharmacyId) async {
    final response = await _client.get(
      path: '../Pharmacy/GetPharmacyBestSellingProducts/$pharmacyId',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  // ==========================================
  // PHARMACY PRODUCTS & INVENTORY ENDPOINTS
  // ==========================================

  /// GET /api/Pharmacy/GetProduct/{productId}
  /// Retrieves product details by product ID.
  Future<dynamic> getProduct(int productId) async {
    final response = await _client.get(
      path: '../Pharmacy/GetProduct/$productId',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// DELETE /api/Pharmacy/DeleteProduct/{productId}
  /// Deletes a product by product ID.
  Future<dynamic> deleteProduct(int productId) async {
    final response = await _client.delete(
      path: '../Pharmacy/DeleteProduct/$productId',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/Pharmacy/GetPharmacyProducts/{pharmacyId}
  /// Gets paginated products for a pharmacy with optional filters.
  Future<dynamic> getPharmacyProducts(
    int pharmacyId, {
    int? categoryId,
    List<int>? subCategoryIds,
    List<int>? brandIds,
    List<int>? genericNameIds,
    int? star,
    int? minPrice,
    int? maxPrice,
    dynamic typeId,
    double? latitude,
    double? longitude,
    double? maxDistanceKm,
    String? searchTerm,
    String? status,
    int? pageNumber,
    int? pageSize,
    bool? pendingRequest,
  }) async {
    final params = <String, dynamic>{
      if (categoryId != null) 'CategoryId': categoryId,
      if (subCategoryIds != null) 'SubCategoryIds': subCategoryIds,
      if (brandIds != null) 'BrandIds': brandIds,
      if (genericNameIds != null) 'GenericNameIds': genericNameIds,
      if (star != null) 'Star': star,
      if (minPrice != null) 'MinPrice': minPrice,
      if (maxPrice != null) 'MaxPrice': maxPrice,
      if (typeId != null) 'TypeId': typeId,
      if (latitude != null) 'Latitude': latitude,
      if (longitude != null) 'Longitude': longitude,
      if (maxDistanceKm != null) 'MaxDistanceKm': maxDistanceKm,
      if (searchTerm != null && searchTerm.isNotEmpty) 'SearchTerm': searchTerm,
      if (status != null && status.isNotEmpty) 'Status': status,
      if (pageNumber != null) 'PageNumber': pageNumber,
      if (pageSize != null) 'PageSize': pageSize,
      if (pendingRequest != null) 'PendingRequest': pendingRequest,
    };
    final response = await _client.get(
      path: '../Pharmacy/GetPharmacyProducts/$pharmacyId',
      params: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// POST /api/Pharmacy/EditProductPriceAndQuantity
  /// Updates product price and stock quantity.
  Future<dynamic> editProductPriceAndQuantity(
    Map<String, dynamic> data,
  ) async {
    final response = await _client.post(
      path: '../Pharmacy/EditProductPriceAndQuantity',
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/Pharmacy/BaseProducts
  /// Gets list of base products.
  Future<dynamic> getBaseProducts({
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
      path: '../Pharmacy/BaseProducts',
      params: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/Pharmacy/BaseProductNames
  /// Gets list of base product names by search query.
  Future<dynamic> getBaseProductNames({String? search}) async {
    final params = <String, dynamic>{
      if (search != null && search.isNotEmpty) 'search': search,
    };
    final response = await _client.get(
      path: '../Pharmacy/BaseProductNames',
      params: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/Pharmacy/{pharmacyId}/inventory
  /// Gets inventory items for a pharmacy.
  Future<dynamic> getPharmacyInventory(
    int pharmacyId, {
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
      path: '../Pharmacy/$pharmacyId/inventory',
      params: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  // ==========================================
  // PHARMACY ORDERS ENDPOINTS
  // ==========================================

  /// GET /api/Pharmacy/{pharmacyId}/GetPharmacyOrder/{orderId}
  /// Gets order details for a pharmacy order.
  Future<dynamic> getPharmacyOrder(int pharmacyId, int orderId) async {
    final response = await _client.get(
      path: '../Pharmacy/$pharmacyId/GetPharmacyOrder/$orderId',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/Pharmacy/{pharmacyId}/Admin/GetPharmacyOrder/{orderId}
  /// Gets order details for an admin pharmacy order.
  Future<dynamic> getAdminPharmacyOrder(int pharmacyId, int orderId) async {
    final response = await _client.get(
      path: '../Pharmacy/$pharmacyId/Admin/GetPharmacyOrder/$orderId',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/Pharmacy/{pharmacyId}/GetPharmacyOrders
  /// Gets paginated list of orders for a pharmacy.
  Future<dynamic> getPharmacyOrders(
    int pharmacyId, {
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
      path: '../Pharmacy/$pharmacyId/GetPharmacyOrders',
      params: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// PUT /api/Pharmacy/{pharmacyId}/AcceptOrDeclineOrderItem/{orderItemId}
  /// Accepts or declines an order item for a pharmacy.
  Future<dynamic> acceptOrDeclineOrderItem(
    int pharmacyId,
    int orderItemId, {
    String? status,
  }) async {
    final params = <String, dynamic>{
      if (status != null && status.isNotEmpty) 'status': status,
    };
    final response = await _client.put(
      path:
          '../Pharmacy/$pharmacyId/AcceptOrDeclineOrderItem/$orderItemId',
      data: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  // ==========================================
  // PHARMACY TRANSACTIONS & WITHDRAWAL ENDPOINTS
  // ==========================================

  /// POST /api/Pharmacy/RequestForRefund
  /// Submits a user refund request.
  Future<bool> requestForRefund(Map<String, dynamic> data) async {
    final response = await _client.post(
      path: '../Pharmacy/RequestForRefund',
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? true;
  }

  /// POST /api/Pharmacy/WithdrawalRequest
  /// Submits a pharmacy withdrawal request.
  Future<dynamic> withdrawalRequest(Map<String, dynamic> data) async {
    final response = await _client.post(
      path: '../Pharmacy/WithdrawalRequest',
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// GET /api/Pharmacy/GetPharmacyTransactions/{pharmacyId}
  /// Gets transactions for a pharmacy.
  Future<dynamic> getPharmacyTransactions(
    int pharmacyId, {
    String? transactionType,
    String? searchTerm,
    String? status,
    int? pageNumber,
    int? pageSize,
    bool? pendingRequest,
  }) async {
    final params = <String, dynamic>{
      if (transactionType != null && transactionType.isNotEmpty)
        'TransactionType': transactionType,
      if (searchTerm != null && searchTerm.isNotEmpty) 'SearchTerm': searchTerm,
      if (status != null && status.isNotEmpty) 'Status': status,
      if (pageNumber != null) 'PageNumber': pageNumber,
      if (pageSize != null) 'PageSize': pageSize,
      if (pendingRequest != null) 'PendingRequest': pendingRequest,
    };
    final response = await _client.get(
      path: '../Pharmacy/GetPharmacyTransactions/$pharmacyId',
      params: params,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  // ==========================================
  // PHARMACY BANK & DOCUMENTS ENDPOINTS
  // ==========================================

  /// GET /api/Pharmacy/GetPharmacyDocuments/{pharmacyId}
  /// Gets documents submitted for a pharmacy.
  Future<dynamic> getPharmacyDocuments(int pharmacyId) async {
    final response = await _client.get(
      path: '../Pharmacy/GetPharmacyDocuments/$pharmacyId',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// POST /api/Pharmacy/{pharmacyId}/AddBankDetails
  /// Adds bank account details for a pharmacy.
  Future<dynamic> addBankDetails(
    int pharmacyId,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.post(
      path: '../Pharmacy/$pharmacyId/AddBankDetails',
      data: data,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// PUT /api/Pharmacy/{pharmacyId}/DeleteBankDetail/{Id}
  /// Deletes a bank detail entry for a pharmacy.
  Future<dynamic> deleteBankDetail(int pharmacyId, int id) async {
    final response = await _client.put(
      path: '../Pharmacy/$pharmacyId/DeleteBankDetail/$id',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// PUT /api/Pharmacy/{pharmacyId}/AddPharmacyProductDocument/{Id}
  /// Adds/uploads a pharmacy product document via multipart form data.
  Future<dynamic> addPharmacyProductDocument(
    int pharmacyId,
    String id, {
    required String documentType,
    required int organisationId,
    required String documentNumber,
    required dynamic file,
  }) async {
    final formData = FormData.fromMap({
      'DocumentType': documentType,
      'OrganisationId': organisationId,
      'DocumentNumber': documentNumber,
    });

    if (file is MultipartFile) {
      formData.files.add(MapEntry('file', file));
    } else if (file is String) {
      formData.files.add(MapEntry('file', await MultipartFile.fromFile(file)));
    }

    final response = await _client.putFormData(
      path: '../Pharmacy/$pharmacyId/AddPharmacyProductDocument/$id',
      data: formData,
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }

  /// PUT /api/Pharmacy/{pharmacyId}/DeletePharmacyProductDocument/{Id}
  /// Deletes a pharmacy product document.
  Future<dynamic> deletePharmacyProductDocument(
    int pharmacyId,
    int id,
  ) async {
    final response = await _client.put(
      path: '../Pharmacy/$pharmacyId/DeletePharmacyProductDocument/$id',
    );
    if (response.hasError) throw response.error;
    return response.data!['data'];
  }
}
