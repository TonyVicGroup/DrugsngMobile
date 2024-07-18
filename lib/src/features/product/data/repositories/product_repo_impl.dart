import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:drugs_ng/src/core/data/models/product_detail.dart';
import 'package:drugs_ng/src/core/utils/app_data_types.dart';
import 'package:drugs_ng/src/core/utils/rest_service.dart';
import 'package:drugs_ng/src/features/product/domain/models/product.dart';
import 'package:drugs_ng/src/features/product/domain/repositories/product_repo.dart';
import 'package:either_dart/either.dart';

class ProductRepositoryImpl extends ProductRepository {
  final RestService service;

  ProductRepositoryImpl(this.service);

  @override
  AsyncApiErrorOr<ProductDetail> getProduct(int id) async {
    try {
      final response = await service.get(path: 'product/$id');
      if (response.hasError) return Left(response.error);

      final data = response.data!['data'] as Map<String, dynamic>;

      return Right(ProductDetail.fromJson(data));
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  @override
  AsyncApiErrorOr<List<Product>> getSimillarProducts(int id) async {
    try {
      final response = await service.get(path: 'product/similar-products');
      if (response.hasError) return Left(response.error);

      // final data = response.data!['data'] as Map<String, dynamic>;

      return Right(
        List<Map>.from(response.data!['data'])
            .map((e) => Product.fromJson(e))
            .toList(),
      );
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
