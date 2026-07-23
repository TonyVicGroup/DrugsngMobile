import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/features/explore/data/datasource/explore_datasource.dart';
import 'package:drugs_ng/features/explore/domain/models/explore_filter.dart';
import 'package:drugs_ng/features/explore/domain/models/generic_brand_name.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:drugs_ng/features/explore/domain/models/sub_category.dart';
import 'package:drugs_ng/features/product/domain/models/product_detail.dart';
import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/features/explore/domain/models/major_category.dart';
import 'package:either_dart/either.dart';

class ExploreRepository {
  final ExploreDatasource datasource = ExploreDatasource();

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

  AsyncApiErrorOr<List<ProductDetail>> loadDrugCategory(
    ExploreFilter filter,
  ) async {
    try {
      final result = await datasource.loadDrugCategory(filter);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<ProductDetail>> loadHealthCareCategory(
    ExploreFilter filter,
  ) async {
    try {
      final result = await datasource.loadHealthCareCategory(filter);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<GenericBrandName>> getBrandNames(
    PageFilter pageFilter,
  ) async {
    try {
      final result = await datasource.getBrandNames(pageFilter);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<GenericBrandName>> getGenericNames(
    PageFilter pageFilter,
  ) async {
    try {
      final result = await datasource.getGenericNames(pageFilter);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<SubCategory>> getSubcategories(
    int categoryId,
    PageFilter filter,
  ) async {
    try {
      final result = await datasource.getSubcategories(categoryId, filter);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
