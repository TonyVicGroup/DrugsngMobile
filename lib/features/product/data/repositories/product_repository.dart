import 'package:dio/dio.dart';
import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/features/home/domain/models/home_data.dart';
import 'package:drugs_ng/features/product/data/datasources/product_datasource.dart';
import 'package:drugs_ng/features/product/domain/models/product_detail.dart';
import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/features/product/domain/models/product.dart';
import 'package:either_dart/either.dart';

class ProductRepository {
  final datasource = ProductDatasource();

  AsyncApiErrorOr<T> _handleRequest<T>(Future<T> Function() request) async {
    try {
      final response = await request();
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<Map<String, dynamic>> createProduct({
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
  }) {
    return _handleRequest(
      () => datasource.createProduct(
        pharmacyId: pharmacyId,
        name: name,
        price: price,
        oldPrice: oldPrice,
        subCategoryId: subCategoryId,
        brandId: brandId,
        genericNameId: genericNameId,
        description: description,
        dosage: dosage,
        warning: warning,
        productFormId: productFormId,
        size: size,
        quantity: quantity,
        approvalStatus: approvalStatus,
        pharmacyIdInBody: pharmacyIdInBody,
        images: images,
      ),
    );
  }

  AsyncApiErrorOr<Map<String, dynamic>> addProductImages({
    required int productId,
    required List<MultipartFile> images,
  }) {
    return _handleRequest(
      () => datasource.addProductImages(productId: productId, images: images),
    );
  }

  AsyncApiErrorOr<Map<String, dynamic>> updateProduct({
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
  }) {
    return _handleRequest(
      () => datasource.updateProduct(
        pharmacyId: pharmacyId,
        productId: productId,
        name: name,
        price: price,
        oldPrice: oldPrice,
        subCategoryId: subCategoryId,
        brandId: brandId,
        genericNameId: genericNameId,
        description: description,
        dosage: dosage,
        warning: warning,
        productFormId: productFormId,
        size: size,
        quantity: quantity,
        approvalStatus: approvalStatus,
        pharmacyIdInBody: pharmacyIdInBody,
        images: images,
      ),
    );
  }

  AsyncApiErrorOr<bool> deleteProductImage(int id) {
    return _handleRequest(() => datasource.deleteProductImage(id));
  }

  AsyncApiErrorOr<bool> deleteProduct(int id) {
    return _handleRequest(() => datasource.deleteProduct(id));
  }

  AsyncApiErrorOr<ProductDetail> getProduct(int id) async {
    return _handleRequest(() => datasource.getProduct(id));
  }

  AsyncApiErrorOr<List<Product>> getBestSellers() {
    return _handleRequest(() => datasource.getBestSellers());
  }

  AsyncApiErrorOr<List<Product>> getNewArrivals() {
    return _handleRequest(() => datasource.getNewArrivals());
  }

  AsyncApiErrorOr<List<Product>> getSimillarProducts(String name) async {
    return _handleRequest(() => datasource.getSimillarProducts(name));
  }

  AsyncApiErrorOr<List<Product>> getSimilarProducts(String name) {
    return _handleRequest(() => datasource.getSimilarProducts(name));
  }

  AsyncApiErrorOr<HomeData> getHomePageProducts() {
    return _handleRequest(() => datasource.getHomePageProducts());
  }

  AsyncApiErrorOr<List<Map<String, dynamic>>> getDrugs({
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
    return _handleRequest(
      () => datasource.getDrugs(
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
  }

  AsyncApiErrorOr<List<Map<String, dynamic>>> getHealthCare({
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
    return _handleRequest(
      () => datasource.getHealthCare(
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
  }

  AsyncApiErrorOr<List<Map<String, dynamic>>> getProductImages({
    required int id,
    String? searchTerm,
    String? status,
    int? pageNumber,
    int? pageSize,
    bool? pendingRequest,
  }) {
    return _handleRequest(
      () => datasource.getProductImages(
        id: id,
        searchTerm: searchTerm,
        status: status,
        pageNumber: pageNumber,
        pageSize: pageSize,
        pendingRequest: pendingRequest,
      ),
    );
  }

  AsyncApiErrorOr<Map<String, dynamic>> getOrganisationProducts({
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
  }) {
    return _handleRequest(
      () => datasource.getOrganisationProducts(
        id: id,
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
  }

  AsyncApiErrorOr<Map<String, dynamic>> getIngredients({
    String? keyword,
    String? value,
  }) {
    return _handleRequest(
      () => datasource.getIngredients(keyword: keyword, value: value),
    );
  }

  AsyncApiErrorOr<Map<String, dynamic>> addIngredients({
    required int id,
    required List<int> ingredients,
  }) {
    return _handleRequest(
      () => datasource.addIngredients(id: id, ingredients: ingredients),
    );
  }

  AsyncApiErrorOr<Map<String, dynamic>> getProductIngredients(int id) {
    return _handleRequest(() => datasource.getProductIngredients(id));
  }

  AsyncApiErrorOr<Map<String, dynamic>> updateIngredients({
    required int id,
    required List<int> ingredients,
  }) {
    return _handleRequest(
      () => datasource.updateIngredients(id: id, ingredients: ingredients),
    );
  }

  AsyncApiErrorOr<Map<String, dynamic>> addProductUsingBaseProductId({
    required int pharmacyId,
    required Map<String, dynamic> payload,
  }) {
    return _handleRequest(
      () => datasource.addProductUsingBaseProductId(
        pharmacyId: pharmacyId,
        payload: payload,
      ),
    );
  }

  AsyncApiErrorOr<Map<String, dynamic>> getBaseProductById(int id) {
    return _handleRequest(() => datasource.getBaseProductById(id));
  }

  AsyncApiErrorOr<bool> deleteIngredients({
    required int id,
    required List<int> ingredientIds,
  }) {
    return _handleRequest(
      () => datasource.deleteIngredients(id: id, ingredientIds: ingredientIds),
    );
  }

  AsyncApiErrorOr<bool> deleteIngredient(int id) {
    return _handleRequest(() => datasource.deleteIngredient(id));
  }
}
