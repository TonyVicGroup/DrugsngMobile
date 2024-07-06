import 'package:drugs_ng/src/features/home/domain/product.dart';

abstract class ExploreDatasource {
  Future<List<Product>> loadCategory(String category);
  Future<List<String>> getBrandNames(String category);
  Future<List<String>> getSubcategories(String category);
}
