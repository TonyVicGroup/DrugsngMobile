import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/features/product/data/datasources/product_datasource.dart';
import 'package:drugs_ng/features/product/domain/models/product_detail.dart';
import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/features/product/domain/models/product.dart';
import 'package:either_dart/either.dart';

class ProductRepository {
  final datasource = ProductDatasource();

  AsyncApiErrorOr<ProductDetail> getProduct(int id) async {
    try {
      final response = await datasource.getProduct(id);
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<Product>> getSimillarProducts(String name) async {
    try {
      final response = await datasource.getSimillarProducts(name);
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
