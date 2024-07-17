import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:drugs_ng/src/core/data/models/product_detail.dart';
import 'package:drugs_ng/src/core/utils/app_data_types.dart';
import 'package:drugs_ng/src/features/explore/domain/models/major_category.dart';
import 'package:drugs_ng/src/features/explore/domain/repository/explore_datasource.dart';
import 'package:either_dart/either.dart';

class ExploreRepository {
  final ExploreDatasource datasource;

  ExploreRepository(this.datasource);

  AsyncApiErrorOr<MajorCategoryData> getMajorCategories() async {
    try {
      final result = await datasource.getMajorCategories();
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<ProductDetail>> loadDrugCategory() async {
    try {
      final result = await datasource.loadDrugCategory();
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<ProductDetail>> loadHealthCareCategory() async {
    try {
      final result = await datasource.loadHealthCareCategory();
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<String>> getBrandNames(String category) async {
    try {
      final result = await datasource.getBrandNames(category);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<String>> getSubcategories(String category) async {
    try {
      final result = await datasource.getSubcategories(category);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
