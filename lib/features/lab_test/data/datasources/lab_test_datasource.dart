import 'dart:convert';

import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:drugs_ng/features/home/domain/models/home_ads.dart';
import 'package:drugs_ng/features/lab_test/domain/models/diagnostic_test.dart';
import 'package:drugs_ng/features/lab_test/domain/models/diagnostic_test_detail.dart';
import 'package:drugs_ng/features/lab_test/domain/models/wellness_package.dart';
import 'package:drugs_ng/features/lab_test/domain/models/wellness_package_detail.dart';
import 'package:flutter/services.dart';

class LabTestDatasource {
  final RestService service = RestService(baseUrl: AppUtils.baseUrl);

  Future<List<HomeAds>> getAds() async {
    final data = await rootBundle.loadString("assets/json/lab_page_data.json");
    await Future.delayed(const Duration(milliseconds: 800));
    final listAds = List.from(json.decode(data)['ads']);
    final ads = listAds.map((ad) => HomeAds.fromJson(ad)).toList();
    return ads;
  }

  Future<List<WellnessPackage>> getPackages(PageFilter pagefilter) async {
    final response = await service.get(
      path: 'wellnessPackage/packages',
      params: pagefilter.toJson(),
    );
    List<WellnessPackage> allPackages =
        List.from(
          response.data!['data'],
        ).map((lT) => WellnessPackage.fromJson(lT)).toList();
    return allPackages;
  }

  Future<List<DiagnosticTest>> getTests(PageFilter pagefilter) async {
    final response = await service.get(
      path: 'test/tests',
      params: pagefilter.toJson(),
    );
    List<DiagnosticTest> allTests =
        List.from(
          response.data!['data'],
        ).map((lT) => DiagnosticTest.fromJson(lT)).toList();
    return allTests;
  }

  Future<WellnessPackageDetail> getPackage(int id) async {
    final response = await service.get(path: 'wellnessPackage/$id');
    return WellnessPackageDetail.fromJson(response.data!['data']);
  }

  Future<DiagnosticTestDetail> getTest(int id) async {
    final response = await service.get(path: 'test/$id');
    return DiagnosticTestDetail.fromJson(response.data!['data']);
  }

  Future<List<WellnessPackage>> getSimilarPackages(String query) async {
    final response = await service.get(
      path: 'wellnessPackage/similar-packages',
      params: {"packageName": query},
    );
    List<WellnessPackage> allPackages =
        List.from(
          response.data!['data'],
        ).map((lT) => WellnessPackage.fromJson(lT)).toList();
    return allPackages;
  }
}
