import 'package:drugs_ng/src/features/home/domain/models/home_ads.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/diagnostic_test.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/test_package.dart';
import 'package:equatable/equatable.dart';

class LabTestHome extends Equatable {
  static const String _testsKey = "diagnostic_test";
  static const String _packagesKey = "test_packages";
  static const String _adsKey = "ads";

  final List<DiagnosticTest> tests;
  final List<TestPackage> packages;
  final List<HomeAds> ads;

  const LabTestHome(
      {required this.tests, required this.packages, required this.ads});

  factory LabTestHome.fromJson(Map json) {
    return LabTestHome(
      tests: List.from(json[_testsKey])
          .map((lT) => DiagnosticTest.fromJson(lT))
          .toList(),
      packages: List.from(json[_packagesKey])
          .map((pK) => TestPackage.fromJson(pK))
          .toList(),
      ads: List.from(json[_adsKey]).map((ad) => HomeAds.fromJson(ad)).toList(),
    );
  }

  @override
  List<Object?> get props => [ads, packages, tests];
}
