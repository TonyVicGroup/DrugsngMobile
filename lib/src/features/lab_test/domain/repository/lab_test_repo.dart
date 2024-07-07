import 'package:drugs_ng/src/core/utils/app_data_types.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/diagnostic_test.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/lab_test_home.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/test_package.dart';

abstract class LabTestRepository {
  AsyncApiErrorOr<LabTestHome> getData();
  AsyncApiErrorOr<List<DiagnosticTest>> getTests();
  AsyncApiErrorOr<List<TestPackage>> getPackages();
}
