import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:drugs_ng/features/home/domain/models/home_ads.dart';
import 'package:drugs_ng/features/lab_test/data/datasources/lab_test_datasource.dart';
import 'package:drugs_ng/features/lab_test/domain/models/diagnostic_test.dart';
import 'package:drugs_ng/features/lab_test/domain/models/diagnostic_test_detail.dart';
import 'package:drugs_ng/features/lab_test/domain/models/wellness_package.dart';
import 'package:drugs_ng/features/lab_test/domain/models/wellness_package_detail.dart';
import 'package:either_dart/either.dart';

class LabTestRepository {
  final datasource = LabTestDatasource();

  // AsyncApiErrorOr<LabTestHome> getData() async {
  //   try {
  //     final data = await rootBundle.loadString(
  //       "assets/json/lab_page_data.json",
  //     );
  //     final mapData = Map<String, dynamic>.from(json.decode(data));
  //     return Right(LabTestHome.fromJson(mapData));
  //   } catch (e) {
  //     return const Left(ApiError.unknown);
  //   }
  // }

  AsyncApiErrorOr<List<HomeAds>> getAds() async {
    try {
      final ads = await datasource.getAds();
      return Right(ads);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<WellnessPackage>> getPackages(
    PageFilter pagefilter,
  ) async {
    try {
      final response = await datasource.getPackages(pagefilter);
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<DiagnosticTest>> getTests(PageFilter pagefilter) async {
    try {
      final response = await datasource.getTests(pagefilter);
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<WellnessPackageDetail> getPackage(int id) async {
    try {
      final response = await datasource.getPackage(id);
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<DiagnosticTestDetail> getTest(int id) async {
    try {
      final response = await datasource.getTest(id);
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<WellnessPackage>> getSimilarPackages(
    String query,
  ) async {
    try {
      final response = await datasource.getSimilarPackages(query);
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
