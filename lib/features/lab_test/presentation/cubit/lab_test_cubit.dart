import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:drugs_ng/features/home/domain/models/home_ads.dart';
import 'package:drugs_ng/features/lab_test/data/repository/lab_test_repository.dart';
import 'package:drugs_ng/features/lab_test/domain/models/diagnostic_test.dart';
import 'package:drugs_ng/features/lab_test/domain/models/wellness_package.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'lab_test_state.dart';

class LabTestCubit extends Cubit<LabTestState> {
  final LabTestRepository repo = LabTestRepository();
  LabTestCubit() : super(LabTestState.initial());

  static const int pageSize = 20;

  Future<void> getAds() async {
    emit(state.copy(adStatus: LoadStatusEnum.loading));
    final result = await repo.getAds();
    result.fold(
      (error) {
        emit(state.copy(adStatus: LoadStatusEnum.failed));
      },
      (data) {
        emit(state.copy(adStatus: LoadStatusEnum.success, ads: data));
      },
    );
  }

  Future<void> getDiagnosticTests() async {
    emit(state.copy(diagnosticStatus: LoadStatusEnum.loading, testTab: true));
    final result = await repo.getTests(
      PageFilter(pageNumber: state.diagnosticPageNumber, pageSize: pageSize),
    );
    result.fold(
      (error) {
        emit(
          state.copy(
            diagnosticStatus: LoadStatusEnum.failed,
            diagnosticError: error,
            testTab: true,
          ),
        );
      },
      (data) {
        emit(
          state.copy(
            diagnosticStatus: LoadStatusEnum.success,
            diagnosticTests: data,
            testTab: true,
          ),
        );
      },
    );
  }

  Future<void> getWellnessPackages() async {
    emit(state.copy(wellnessStatus: LoadStatusEnum.loading, testTab: false));
    final result = await repo.getPackages(
      PageFilter(pageNumber: state.wellnessPageNumber, pageSize: pageSize),
    );
    result.fold(
      (error) {
        emit(
          state.copy(
            wellnessStatus: LoadStatusEnum.failed,
            wellnessError: error,
            testTab: false,
          ),
        );
      },
      (data) {
        emit(
          state.copy(
            wellnessStatus: LoadStatusEnum.success,
            wellnessPackages: data,
            testTab: false,
          ),
        );
      },
    );
  }

  void toggleTab(bool isTab1) {
    emit(state.copy(testTab: isTab1));
  }

  /// call refresh on either wellness package or diagnostic test
  Future<void> fetchMore() async {
    if (state.testTab) {
      int pageNumber = state.diagnosticPageNumber;
      if (state.diagnosticTests.isNotEmpty) {
        pageNumber += 1;
      }
      final result = await repo.getTests(
        PageFilter(pageNumber: pageNumber, pageSize: pageSize),
      );
      result.fold(
        (error) {
          emit(
            state.copy(
              diagnosticStatus: LoadStatusEnum.failed,
              diagnosticError: error,
              testTab: true,
            ),
          );
        },
        (data) {
          emit(
            state.copy(
              diagnosticStatus: LoadStatusEnum.success,
              diagnosticTests: state.diagnosticTests..addAll(data),
              diagnosticPageNumber: pageNumber,
              testTab: true,
            ),
          );
        },
      );
    } else {
      int pageNumber = state.wellnessPageNumber;
      if (state.wellnessPackages.isNotEmpty) {
        pageNumber += 1;
      }
      final result = await repo.getPackages(
        PageFilter(pageNumber: pageNumber, pageSize: pageSize),
      );
      result.fold(
        (error) {
          emit(
            state.copy(
              wellnessStatus: LoadStatusEnum.failed,
              wellnessError: error,
            ),
          );
        },
        (data) {
          emit(
            state.copy(
              wellnessStatus: LoadStatusEnum.success,
              wellnessPackages: state.wellnessPackages..addAll(data),
              wellnessPageNumber: pageNumber,
            ),
          );
        },
      );
    }
  }

  /// call refresh on wellness package and diagnostic test
  Future<void> refreshAll() async {
    List<Future> futures = [
      getAds(),
      getWellnessPackages(),
      getDiagnosticTests(),
    ];
    await Future.wait(futures);
  }
}
