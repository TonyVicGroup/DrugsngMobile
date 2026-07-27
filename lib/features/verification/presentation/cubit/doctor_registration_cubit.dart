import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorRegistrationCubit extends Cubit<DoctorRegistrationState> {
  DoctorRegistrationCubit() : super(const DoctorRegistrationState());

  void changeStage(int stage) {
    emit(state.copyWith(stage: stage));
  }
}

class DoctorRegistrationState extends Equatable {
  final int stage;
  final LoadStatusEnum verifyLicenseStatus;
  final LoadStatusEnum idVerifyStatus;
  final String? error;

  const DoctorRegistrationState({
    this.stage = 0,
    this.verifyLicenseStatus = LoadStatusEnum.initial,
    this.idVerifyStatus = LoadStatusEnum.initial,
    this.error,
  });

  DoctorRegistrationState copyWith({
    int? stage,
    LoadStatusEnum? verifyLicenseStatus,
    LoadStatusEnum? idVerifyStatus,
    String? error,
  }) {
    return DoctorRegistrationState(
      stage: stage ?? this.stage,
      verifyLicenseStatus: verifyLicenseStatus ?? this.verifyLicenseStatus,
      idVerifyStatus: idVerifyStatus ?? this.idVerifyStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    stage,
    verifyLicenseStatus,
    idVerifyStatus,
    error,
  ];
}
