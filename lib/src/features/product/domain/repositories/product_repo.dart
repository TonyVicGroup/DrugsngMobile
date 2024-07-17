import 'package:drugs_ng/src/core/data/models/product_detail.dart';
import 'package:drugs_ng/src/core/utils/app_data_types.dart';

abstract class ProductRepository {
  AsyncApiErrorOr<ProductDetail> getProduct(int id);
}
