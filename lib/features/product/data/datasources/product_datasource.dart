import 'package:dio/dio.dart';
import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/home/domain/models/home_data.dart';
import 'package:drugs_ng/features/product/domain/models/product_detail.dart';
import 'package:drugs_ng/features/product/domain/models/product.dart';

class ProductDatasource {
  final RestService service = RestService(baseUrl: AppUtils.baseUrl);

  Future<Map<String, dynamic>> createProduct({
    required int pharmacyId,
    required String name,
    required double price,
    double? oldPrice,
    required int subCategoryId,
    required int brandId,
    required int genericNameId,
    required String description,
    required String dosage,
    required String warning,
    required int productFormId,
    required String size,
    required int quantity,
    required String approvalStatus,
    required int pharmacyIdInBody,
    List<MultipartFile>? images,
  }) async {
    final formData = FormData.fromMap({
      'Name': name,
      'Price': price,
      if (oldPrice != null) 'OldPrice': oldPrice,
      'SubCategoryId': subCategoryId,
      'BrandId': brandId,
      'GenericNameId': genericNameId,
      'Description': description,
      'Dosage': dosage,
      'Warning': warning,
      'ProductFormId': productFormId,
      'Size': size,
      'Quantity': quantity,
      'ApprovalStatus': approvalStatus,
      'PharmacyId': pharmacyIdInBody,
      if (images != null && images.isNotEmpty) 'Images': images,
    });

    final response = await service.postFormData(
      path: 'product/$pharmacyId/CreateProduct',
      data: formData,
    );
    if (response.hasError) throw response.error;
    return Map<String, dynamic>.from(response.data!['data'] ?? {});
  }

  Future<Map<String, dynamic>> addProductImages({
    required int productId,
    required List<MultipartFile> images,
  }) async {
    final formData = FormData.fromMap({
      'ProductId': productId,
      'Images': images,
    });

    final response = await service.postFormData(
      path: 'product/AddProductImages',
      data: formData,
    );
    if (response.hasError) throw response.error;
    return Map<String, dynamic>.from(response.data!['data'] ?? {});
  }

  Future<Map<String, dynamic>> updateProduct({
    required int pharmacyId,
    required int productId,
    required String name,
    required double price,
    double? oldPrice,
    required int subCategoryId,
    required int brandId,
    required int genericNameId,
    required String description,
    required String dosage,
    required String warning,
    required int productFormId,
    required String size,
    required int quantity,
    required String approvalStatus,
    required int pharmacyIdInBody,
    List<MultipartFile>? images,
  }) async {
    final formData = FormData.fromMap({
      'ProductId': productId,
      'Name': name,
      'Price': price,
      if (oldPrice != null) 'OldPrice': oldPrice,
      'SubCategoryId': subCategoryId,
      'BrandId': brandId,
      'GenericNameId': genericNameId,
      'Description': description,
      'Dosage': dosage,
      'Warning': warning,
      'ProductFormId': productFormId,
      'Size': size,
      'Quantity': quantity,
      'ApprovalStatus': approvalStatus,
      'PharmacyId': pharmacyIdInBody,
      if (images != null && images.isNotEmpty) 'Images': images,
    });

    final response = await service.putFormData(
      path: 'product/$pharmacyId/UpdateProduct',
      data: formData,
    );
    if (response.hasError) throw response.error;
    return Map<String, dynamic>.from(response.data!['data'] ?? {});
  }

  Future<bool> deleteProductImage(int id) async {
    final response = await service.delete(path: 'product/images/$id');
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? true;
  }

  Future<bool> deleteProduct(int id) async {
    final response = await service.delete(path: 'product/DeleteProduct/$id');
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? true;
  }

  Future<ProductDetail> getProduct(int id) async {
    final response = await service.get(path: 'product/GetProduct/$id');
    if (response.hasError) throw response.error;
    final data = response.data!['data'] as Map<String, dynamic>;
    return ProductDetail.fromJson(data);
  }

  Future<List<Product>> getBestSellers() async {
    final response = await service.get(path: 'product/best-sellers');
    if (response.hasError) throw response.error;

    return List<Map>.from(
      response.data!['data'],
    ).map((e) => Product.fromJson(e)).toList();
  }

  Future<List<Product>> getNewArrivals() async {
    final response = await service.get(path: 'product/new-arrivals');
    if (response.hasError) throw response.error;

    return List<Map>.from(
      response.data!['data'],
    ).map((e) => Product.fromJson(e)).toList();
  }

  Future<List<Product>> getSimillarProducts(String name) async {
    final response = await service.get(
      path: 'product/similar-products',
      params: {'productName': name},
    );

    if (response.hasError) throw response.error;

    return List<Map>.from(
      response.data!['data'],
    ).map((e) => Product.fromJson(e)).toList();
  }

  Future<List<Product>> getSimilarProducts(String name) {
    return getSimillarProducts(name);
  }

  Future<HomeData> getHomePageProducts() async {
    final response = await service.get(path: 'product/home-page');
    if (response.hasError) throw response.error;
    return HomeData.fromJson(response.data!['data'] ?? {});
  }

  Future<List<Map<String, dynamic>>> getDrugs({
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
    final response = await service.get(
      path: 'product/drugs',
      params: _buildProductFilterQuery(
        categoryId: categoryId,
        subCategoryIds: subCategoryIds,
        brandIds: brandIds,
        genericNameIds: genericNameIds,
        star: star,
        minPrice: minPrice,
        maxPrice: maxPrice,
        typeId: typeId,
        latitude: latitude,
        longitude: longitude,
        maxDistanceKm: maxDistanceKm,
        searchTerm: searchTerm,
        status: status,
        pageNumber: pageNumber,
        pageSize: pageSize,
        pendingRequest: pendingRequest,
      ),
    );
    if (response.hasError) throw response.error;

    final data = List.from(response.data!['data'] ?? const []);
    return data.map((item) => Map<String, dynamic>.from(item as Map)).toList();
  }

  Future<List<Map<String, dynamic>>> getHealthCare({
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
    final response = await service.get(
      path: 'product/health-care',
      params: _buildProductFilterQuery(
        categoryId: categoryId,
        subCategoryIds: subCategoryIds,
        brandIds: brandIds,
        genericNameIds: genericNameIds,
        star: star,
        minPrice: minPrice,
        maxPrice: maxPrice,
        typeId: typeId,
        latitude: latitude,
        longitude: longitude,
        maxDistanceKm: maxDistanceKm,
        searchTerm: searchTerm,
        status: status,
        pageNumber: pageNumber,
        pageSize: pageSize,
        pendingRequest: pendingRequest,
      ),
    );
    if (response.hasError) throw response.error;

    final data = List.from(response.data!['data'] ?? const []);
    return data.map((item) => Map<String, dynamic>.from(item as Map)).toList();
  }

  Future<List<Map<String, dynamic>>> getProductImages({
    required int id,
    String? searchTerm,
    String? status,
    int? pageNumber,
    int? pageSize,
    bool? pendingRequest,
  }) async {
    final response = await service.get(
      path: 'product/$id/Images',
      params: {
        if (searchTerm != null && searchTerm.isNotEmpty)
          'SearchTerm': searchTerm,
        if (status != null && status.isNotEmpty) 'Status': status,
        if (pageNumber != null) 'PageNumber': pageNumber,
        if (pageSize != null) 'PageSize': pageSize,
        if (pendingRequest != null) 'PendingRequest': pendingRequest,
      },
    );
    if (response.hasError) throw response.error;

    final data = List.from(response.data!['data'] ?? const []);
    return data.map((item) => Map<String, dynamic>.from(item as Map)).toList();
  }

  Future<Map<String, dynamic>> getOrganisationProducts({
    required int id,
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
    final response = await service.get(
      path: 'product/$id/organisation-product',
      params: _buildProductFilterQuery(
        categoryId: categoryId,
        subCategoryIds: subCategoryIds,
        brandIds: brandIds,
        genericNameIds: genericNameIds,
        star: star,
        minPrice: minPrice,
        maxPrice: maxPrice,
        typeId: typeId,
        latitude: latitude,
        longitude: longitude,
        maxDistanceKm: maxDistanceKm,
        searchTerm: searchTerm,
        status: status,
        pageNumber: pageNumber,
        pageSize: pageSize,
        pendingRequest: pendingRequest,
      ),
    );
    if (response.hasError) throw response.error;
    return Map<String, dynamic>.from(response.data!['data'] ?? {});
  }

  Future<Map<String, dynamic>> getIngredients({
    String? keyword,
    String? value,
  }) async {
    final response = await service.get(
      path: 'product/ingredients',
      params: {
        if (keyword != null && keyword.isNotEmpty) 'Keyword': keyword,
        if (value != null && value.isNotEmpty) 'Value': value,
      },
    );
    if (response.hasError) throw response.error;
    return Map<String, dynamic>.from(response.data!['data'] ?? {});
  }

  Future<Map<String, dynamic>> addIngredients({
    required int id,
    required List<int> ingredients,
  }) async {
    final response = await service.post(
      path: 'product/$id/add-ingredients',
      queryParameters: {'Ingredients': ingredients},
    );
    if (response.hasError) throw response.error;
    return Map<String, dynamic>.from(response.data!['data'] ?? {});
  }

  Future<Map<String, dynamic>> getProductIngredients(int id) async {
    final response = await service.get(path: 'product/$id/ingredient');
    if (response.hasError) throw response.error;
    return Map<String, dynamic>.from(response.data!['data'] ?? {});
  }

  Future<Map<String, dynamic>> updateIngredients({
    required int id,
    required List<int> ingredients,
  }) async {
    final response = await service.post(
      path: 'product/$id/update-ingredients',
      queryParameters: {'Ingredients': ingredients},
    );
    if (response.hasError) throw response.error;
    return Map<String, dynamic>.from(response.data!['data'] ?? {});
  }

  Future<Map<String, dynamic>> addProductUsingBaseProductId({
    required int pharmacyId,
    required Map<String, dynamic> payload,
  }) async {
    final response = await service.post(
      path: 'product/$pharmacyId/add-product-using-base-productId',
      data: payload,
    );
    if (response.hasError) throw response.error;
    return Map<String, dynamic>.from(response.data!['data'] ?? {});
  }

  Future<Map<String, dynamic>> getBaseProductById(int id) async {
    final response = await service.get(path: 'product/base-products/$id');
    if (response.hasError) throw response.error;
    return Map<String, dynamic>.from(response.data!['data'] ?? {});
  }

  Future<bool> deleteIngredients({
    required int id,
    required List<int> ingredientIds,
  }) async {
    final response = await service.get(
      path: 'product/$id/delete-ingredients',
      params: {'ingredientIds': ingredientIds},
    );
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? false;
  }

  Future<bool> deleteIngredient(int id) async {
    final response = await service.get(path: 'product/$id/delete-ingredient');
    if (response.hasError) throw response.error;
    return response.data!['data'] as bool? ?? false;
  }

  Map<String, dynamic> _buildProductFilterQuery({
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
  }) {
    return <String, dynamic>{
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
  }
}
