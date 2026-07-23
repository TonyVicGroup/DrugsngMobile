import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/features/search/data/datasources/search_datasource.dart';
import 'package:drugs_ng/features/search/data/models/search_item.dart';
import 'package:drugs_ng/features/search/domain/repositories/search_repo.dart';
import 'package:either_dart/either.dart';

class SearchRepository {
  final datasource = SearchDatasource();

  AsyncApiErrorOr<List<SearchItem>> diagnosticTest(String query) async {
    try {
      final result = await datasource.diagnosticTest(query);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<SearchItem>> product(String query) async {
    try {
      final result = await datasource.product(query);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<SearchItem>> wellnessPackage(String query) async {
    try {
      final result = await datasource.wellnessPackage(query);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<SearchItem>> testAndPackage(String query) async {
    try {
      final result = await datasource.testAndPackage(query);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<SearchItem>> all(String query) async {
    try {
      final result = await datasource.all(query);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
