import 'package:drugs_ng/features/prescription/data/repositories/prescription_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/features/prescription/data/models/prescription.dart';
import 'package:equatable/equatable.dart';

part 'prescription_state.dart';

class PrescriptionCubit extends Cubit<PrescriptionState> {
  final PrescriptionRepository repo = PrescriptionRepository();
  PrescriptionCubit() : super(const PrescriptionInitial());

  Future getData() async {
    emit(PrescriptionLoading(state.prescriptions));
    final result = await repo.getData();
    result.fold(
      (left) {
        emit(PrescriptionError(state.prescriptions, left));
      },
      (right) {
        emit(PrescriptionSuccess(right));
      },
    );
  }

  Future addData(int userId, PlatformFile file) async {
    emit(PrescriptionUploadLoading(state.prescriptions));
    final result = await repo.addData(userId, file);
    result.fold(
      (left) {
        emit(PrescriptionError(state.prescriptions, left));
      },
      (right) {
        final presList = [right, ...state.prescriptions];
        emit(PrescriptionUploadSuccess(presList));
      },
    );
  }

  Future deletePrescription(int productId) async {
    emit(PrescriptionLoading(state.prescriptions));
    final result = await repo.delete(productId);
    result.fold(
      (left) {
        emit(PrescriptionError(state.prescriptions, left));
      },
      (right) {
        state.prescriptions.removeWhere((pres) => pres.id == productId);
        emit(PrescriptionSuccess(List.from(state.prescriptions)));
      },
    );
  }

  void resetData() {
    emit(const PrescriptionInitial());
  }
}
