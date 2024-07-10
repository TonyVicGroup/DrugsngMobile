import 'package:drugs_ng/src/core/enum/request_status.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/diagnostic_test.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/test_package.dart';
import 'package:drugs_ng/src/features/lab_test/domain/repository/lab_test_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'lab_test_discovery_state.dart';

class LabTestDiscoveryCubit extends Cubit<LabTestDiscoveryState> {
  final LabTestRepository repo;
  LabTestDiscoveryCubit(this.repo) : super(LabTestDiscoveryInitial());

  Future<void> getTests() async {
    emit(LabTestDiscoveryLoading(
      state.tests,
      state.packages,
      Status.loading,
      state.packageStatus,
    ));
    final result = await repo.getTests();
    result.fold((error) {
      emit(LabTestDiscoveryFailed(
        state.tests,
        state.packages,
        Status.failed,
        state.packageStatus,
        error.message,
      ));
    }, (data) {
      emit(LabTestDiscoverySuccess(
        data,
        state.packages,
        Status.success,
        state.packageStatus,
      ));
    });
  }

  Future<void> getPackages() async {
    emit(LabTestDiscoveryLoading(
      state.tests,
      state.packages,
      state.testStatus,
      Status.loading,
    ));
    final result = await repo.getPackages();
    result.fold((error) {
      emit(LabTestDiscoveryFailed(
        state.tests,
        state.packages,
        state.testStatus,
        Status.failed,
        error.message,
      ));
    }, (data) {
      emit(LabTestDiscoverySuccess(
        state.tests,
        data,
        state.testStatus,
        Status.loading,
      ));
    });
  }
}
