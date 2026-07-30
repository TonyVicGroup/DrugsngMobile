import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/prescription/data/repositories/prescription_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drugs_ng/features/prescription/data/models/prescription.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

enum PrescriptionTabEnum {
  newUpload,
  recentUploads;

  String get displayName => switch (this) {
    newUpload => "New Upload",
    recentUploads => "Recent Uploads",
  };

  int get indexNumber => switch (this) {
    newUpload => 0,
    recentUploads => 1,
  };

  static PrescriptionTabEnum fromIndex(int index) => switch (index) {
    1 => recentUploads,
    _ => newUpload,
  };

  @override
  String toString() => displayName;
}

class PrescriptionCubit extends Cubit<PrescriptionState> {
  final PrescriptionRepository repo = PrescriptionRepository();
  PrescriptionCubit() : super(const PrescriptionState());

  void changeTab(PrescriptionTabEnum tab) {
    emit(state.copyWith(tab: tab));
  }

  void pickFile(PlatformFile file) {
    emit(state.copyWith(pickedFile: file, clearPickedFile: false));
  }

  void clearPickedFile() {
    emit(state.copyWith(clearPickedFile: true));
  }

  Future getData() async {
    final account = GetIt.I.get<AuthCubit>().state.account;
    if (account == null) return;
    emit(state.copyWith(status: LoadStatusEnum.loading));
    final result = await repo.getData(account.userId);
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

  Future submitPrescription() async {
    final account = GetIt.I.get<AuthCubit>().state.account;
    if (account == null) return;
    if (state.pickedFile == null) return;
    emit(state.copyWith(uploadStatus: LoadStatusEnum.loading));
    final result = await repo.addData(account.userId, state.pickedFile!);
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
  final PlatformFile? pickedFile;

  const PrescriptionState({
    this.recentUploads = const [],
    this.status = LoadStatusEnum.initial,
    this.uploadStatus = LoadStatusEnum.initial,
    this.deleteStatus = LoadStatusEnum.initial,
    this.tab = PrescriptionTabEnum.newUpload,
    this.pickedFile,
    this.error,
  });

  PrescriptionState copyWith({
    List<Prescription>? recentUploads,
    LoadStatusEnum? status,
    LoadStatusEnum? uploadStatus,
    LoadStatusEnum? deleteStatus,
    PrescriptionTabEnum? tab,
    String? error,
    PlatformFile? pickedFile,
    bool clearPickedFile = false,
  }) {
    return PrescriptionState(
      recentUploads: recentUploads ?? this.recentUploads,
      status: status ?? this.status,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      pickedFile: clearPickedFile ? null : pickedFile ?? this.pickedFile,
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
    pickedFile,
    tab,
    error,
  ];
}
