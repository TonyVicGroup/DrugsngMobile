import 'package:drugs_ng/src/core/data/models/product_detail.dart';
import 'package:drugs_ng/src/core/utils/app_data_types.dart';
import 'package:drugs_ng/src/features/product/domain/models/product.dart';

abstract class ProductRepository {
  AsyncApiErrorOr<ProductDetail> getProduct(int id);
  AsyncApiErrorOr<List<Product>> getSimillarProducts(int id);
}
