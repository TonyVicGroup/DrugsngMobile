import 'package:drugs_ng/src/core/enum/request_status.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/diagnostic_test.dart';
import 'package:drugs_ng/src/features/lab_test/domain/models/test_package.dart';
import 'package:drugs_ng/src/features/lab_test/domain/repository/lab_test_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'lab_test_discovery_state.dart';

class LabTestDiscoveryCubit extends Cubit<LabTestDiscoveryState> {
  final LabTestRepository repo;

  LabTestDiscoveryCubit(this.repo) : super(LabTestDiscoveryState.initial());

  Future<void> getTests() async {
    emit(state.copy(
      testStatus: Status.loading,
      testTab: true,
    ));
    final result = await repo.getTests();
    result.fold((error) {
      emit(state.copy(
        testStatus: Status.failed,
        testTab: true,
      ));
    }, (data) {
      emit(state.copy(
        testStatus: Status.success,
        tests: data,
        testTab: true,
      ));
    });
  }

  Future<void> getPackages() async {
    emit(state.copy(
      packageStatus: Status.loading,
      testTab: false,
    ));
    final result = await repo.getPackages();
    result.fold((error) {
      emit(state.copy(
        packageStatus: Status.failed,
        testTab: false,
      ));
    }, (data) {
      emit(state.copy(
        packageStatus: Status.success,
        packages: data,
        testTab: false,
      ));
    });
  }

  void toggleTab(bool isTab1) {
    emit(state.copy(testTab: isTab1));
  }
}
