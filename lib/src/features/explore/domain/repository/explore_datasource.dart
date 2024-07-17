import 'package:drugs_ng/src/core/data/models/product_detail.dart';
import 'package:drugs_ng/src/features/explore/domain/models/major_category.dart';

abstract class ExploreDatasource {
  Future<List<ProductDetail>> loadDrugCategory();
  Future<List<ProductDetail>> loadHealthCareCategory();
  Future<List<String>> getBrandNames(String category);
  Future<List<String>> getSubcategories(String category);
  Future<MajorCategoryData> getMajorCategories();
}
