import 'package:drugs_ng/src/features/lab_test/domain/models/lab_test_home.dart';
import 'package:drugs_ng/src/features/lab_test/domain/repository/lab_test_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'lab_test_state.dart';

class LabTestCubit extends Cubit<LabTestState> {
  final LabTestRepository repo;
  LabTestCubit(this.repo) : super(const LabTestInitial());

  Future<void> getData() async {
    emit(LabTestLoading(state.data));
    final result = await repo.getData();
    result.fold((error) {
      emit(LabTestError(state.data, error.message));
    }, (data) {
      emit(LabTestSuccess(data));
    });
  }

  Future<void> reload() async {
    final result = await repo.getData();
    result.fold((error) {
      emit(LabTestError(state.data, error.message));
    }, (data) {
      emit(LabTestSuccess(data));
    });
  }
}
