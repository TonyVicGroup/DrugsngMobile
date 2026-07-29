import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/prescription/data/repositories/prescription_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drugs_ng/features/prescription/data/models/prescription.dart';
import 'package:equatable/equatable.dart';

enum PrescriptionTabEnum { newUpload, recentUploads }

class PrescriptionCubit extends Cubit<PrescriptionState> {
  final PrescriptionRepository repo = PrescriptionRepository();
  PrescriptionCubit() : super(const PrescriptionState());

  void changeTab(PrescriptionTabEnum tab) {
    emit(state.copyWith(tab: tab));
  }

  Future getData() async {
    emit(state.copyWith(status: LoadStatusEnum.loading));
    final result = await repo.getData();
    result.fold(
      (left) {
        emit(
          state.copyWith(status: LoadStatusEnum.failed, error: left.message),
        );
      },
      (right) {
        emit(
          state.copyWith(status: LoadStatusEnum.success, recentUploads: right),
        );
      },
    );
  }

  Future addData(int userId, PlatformFile file) async {
    emit(state.copyWith(uploadStatus: LoadStatusEnum.loading));
    final result = await repo.addData(userId, file);
    result.fold(
      (left) {
        emit(
          state.copyWith(
            uploadStatus: LoadStatusEnum.failed,
            error: left.message,
          ),
        );
      },
      (right) {
        final presList = [right, ...state.recentUploads];
        emit(
          state.copyWith(
            uploadStatus: LoadStatusEnum.success,
            recentUploads: presList,
          ),
        );
      },
    );
  }

  Future deletePrescription(int productId) async {
    emit(state.copyWith(deleteStatus: LoadStatusEnum.loading));
    final result = await repo.delete(productId);
    result.fold(
      (left) {
        emit(
          state.copyWith(
            deleteStatus: LoadStatusEnum.failed,
            error: left.message,
          ),
        );
      },
      (right) {
        state.recentUploads.removeWhere((pres) => pres.id == productId);
        emit(
          state.copyWith(
            recentUploads: List.from(state.recentUploads),
            deleteStatus: LoadStatusEnum.success,
          ),
        );
      },
    );
  }

  void resetData() {
    emit(const PrescriptionState());
  }
}

class PrescriptionState extends Equatable {
  final List<Prescription> recentUploads;
  final LoadStatusEnum status;
  final LoadStatusEnum uploadStatus;
  final LoadStatusEnum deleteStatus;
  final PrescriptionTabEnum tab;
  final String? error;

  const PrescriptionState({
    this.recentUploads = const [],
    this.status = LoadStatusEnum.initial,
    this.uploadStatus = LoadStatusEnum.initial,
    this.deleteStatus = LoadStatusEnum.initial,
    this.tab = PrescriptionTabEnum.newUpload,
    this.error,
  });

  PrescriptionState copyWith({
    List<Prescription>? recentUploads,
    LoadStatusEnum? status,
    LoadStatusEnum? uploadStatus,
    LoadStatusEnum? deleteStatus,
    PrescriptionTabEnum? tab,
    String? error,
  }) {
    return PrescriptionState(
      recentUploads: recentUploads ?? this.recentUploads,
      status: status ?? this.status,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      tab: tab ?? this.tab,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    recentUploads,
    status,
    uploadStatus,
    deleteStatus,
    tab,
    error,
  ];
}
