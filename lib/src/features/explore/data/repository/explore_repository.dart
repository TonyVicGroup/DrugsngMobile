import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:drugs_ng/src/core/utils/app_data_types.dart';
import 'package:drugs_ng/src/features/explore/domain/repository/explore_datasource.dart';
import 'package:drugs_ng/src/features/home/domain/product.dart';
import 'package:either_dart/either.dart';

class ExploreRepository {
  final ExploreDatasource datasource;

  ExploreRepository(this.datasource);

  AsyncApiErrorOr<List<Product>> loadCategory(String category) async {
    try {
      final result = await datasource.loadCategory(category);
      return Right(result);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<String>> getBrandNames(String category) async {
    try {
      final result = await datasource.getBrandNames(category);
      return Right(result);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<String>> getSubcategories(String category) async {
    try {
      final result = await datasource.getSubcategories(category);
      return Right(result);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
