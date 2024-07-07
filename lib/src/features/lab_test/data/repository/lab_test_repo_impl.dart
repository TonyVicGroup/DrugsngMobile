import 'dart:convert';

import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:drugs_ng/src/core/utils/app_data_types.dart';
import 'package:drugs_ng/src/core/utils/rest_service.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/diagnostic_test.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/lab_test_home.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/test_package.dart';
import 'package:drugs_ng/src/features/lab_test/domain/repository/lab_test_repo.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/services.dart';

class LabTestRepositoryImpl extends LabTestRepository {
  final RestService service;

  LabTestRepositoryImpl(this.service);

  @override
  AsyncApiErrorOr<LabTestHome> getData() async {
    try {
      final data = await rootBundle.loadString(
        "assets/json/lab_page_data.json",
      );
      final mapData = Map<String, dynamic>.from(json.decode(data));
      return Right(LabTestHome.fromJson(mapData));
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  @override
  AsyncApiErrorOr<List<TestPackage>> getPackages() async {
    try {
      final data = await rootBundle.loadString(
        "assets/json/lab_page_data.json",
      );
      final mapData = Map<String, dynamic>.from(json.decode(data));
      List<TestPackage> allPackages = List.from(mapData["test_packages"])
          .map((lT) => TestPackage.fromJson(lT))
          .toList();
      return Right(allPackages);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  @override
  AsyncApiErrorOr<List<DiagnosticTest>> getTests() async {
    try {
      final data = await rootBundle.loadString(
        "assets/json/lab_page_data.json",
      );
      final mapData = Map<String, dynamic>.from(json.decode(data));
      List<DiagnosticTest> allTests = List.from(mapData["diagnostic_test"])
          .map((lT) => DiagnosticTest.fromJson(lT))
          .toList();
      return Right(allTests);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
