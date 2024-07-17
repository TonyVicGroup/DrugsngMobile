import 'package:drugs_ng/src/core/data/models/product_detail.dart';
import 'package:drugs_ng/src/core/utils/rest_service.dart';
import 'package:drugs_ng/src/features/explore/domain/models/major_category.dart';
import 'package:drugs_ng/src/features/explore/domain/repository/explore_datasource.dart';

class ExploreDatasourceImpl extends ExploreDatasource {
  final RestService service;
  ExploreDatasourceImpl(this.service);

  @override
  Future<List<ProductDetail>> loadDrugCategory() async {
    final response = await service.get(path: 'product/drugs');
    if (response.hasError) throw response.error;
    return List<Map>.from(response.data!['data'])
        .map((prod) => ProductDetail.fromJson(prod))
        .toList();
  }

  @override
  Future<List<ProductDetail>> loadHealthCareCategory() async {
    final response = await service.get(path: 'product/health-care');
    if (response.hasError) throw response.error;
    return List<Map>.from(response.data!['data'])
        .map((prod) => ProductDetail.fromJson(prod))
        .toList();
  }

  @override
  Future<List<String>> getBrandNames(String category) async {
    await Future.delayed(const Duration(seconds: 3));
    return [
      "Benadryl",
      "Smile",
      "Try",
      "To",
      "Think",
      "of",
      "a",
      "brand",
      "name"
    ];
  }

  @override
  Future<List<String>> getSubcategories(String category) async {
    await Future.delayed(const Duration(seconds: 3));
    return [
      "Benadryl",
      "Smile",
      "Try",
      "To",
      "Think",
      "of",
      "a",
      "brand",
      "name"
    ];
  }

  @override
  Future<MajorCategoryData> getMajorCategories() async {
    final response = await service.get(path: 'category/categories');
    if (response.hasError) throw response.error;
    return MajorCategoryData.fromJson(response.data!['data']);
  }
}
