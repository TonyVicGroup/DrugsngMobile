import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_data.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_details.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_home_data.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_parameters.dart';
import 'package:drugs_ng/features/consultation/data/repository/consultation_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class ConsultationCubit extends Cubit<ConsultationState> {
  final ConsultationRepository repo = ConsultationRepository();
  ConsultationCubit() : super(ConsultationState.initial());

  Future<void> getHomeData({bool refreshPage = true}) async {
    // refresh home page
    if (refreshPage) {
      emit(state.copyWith(getConsultationsStatus: LoadStatusEnum.loading));
    }
    final result = await repo.getHomeData();
    result.fold(
      (left) {
        emit(
          state.copyWith(
            error: left.message,
            getConsultationsStatus: LoadStatusEnum.failed,
          ),
        );
      },
      (right) {
        emit(
          state.copyWith(
            getConsultationsStatus: LoadStatusEnum.success,
            homeData: right,
          ),
        );
      },
    );
  }

  // Future<void> getConsultations() async {
  //   emit(ConsultationStateLoading(
  //     state.consultations,
  //     state.params,
  //     state.homeData,
  //   ));
  //   final result = await repo.getConsultations(state.params);
  //   result.fold((left) {
  //     emit(
  //       ConsultationStateError(
  //         left,
  //         state.consultations,
  //         state.params,
  //         state.homeData,
  //       ),
  //     );
  //   }, (right) {
  //     emit(
  //       ConsultationStateSuccess(
  //         right,
  //         state.params,
  //         state.homeData,
  //       ),
  //     );
  //   });
  // }

  Future<void> addConsultation(ConsultationData data) async {
    emit(state.copyWith(addConsultationStatus: LoadStatusEnum.loading));
    final result = await repo.addConsultation(data);
    result.fold(
      (left) {
        emit(
          state.copyWith(
            addConsultationStatus: LoadStatusEnum.failed,
            error: left.message,
          ),
        );
      },
      (right) {
        emit(state.copyWith(addConsultationStatus: LoadStatusEnum.success));
      },
    );
  }
}

class ConsultationState extends Equatable {
  final ConsultationHomeData homeData;
  final List<ConsultationDetails> consultations;
  final ConsultationParameters params;
  final LoadStatusEnum getConsultationsStatus;
  final LoadStatusEnum addConsultationStatus;
  final String? error;

  const ConsultationState({
    required this.params,
    required this.homeData,
    this.consultations = const [],
    this.getConsultationsStatus = LoadStatusEnum.initial,
    this.addConsultationStatus = LoadStatusEnum.initial,
    this.error,
  });

  factory ConsultationState.initial() => ConsultationState(
    params: ConsultationParameters.initial(),
    homeData: ConsultationHomeData.initial(),
  );

  ConsultationState copyWith({
    List<ConsultationDetails>? consultations,
    ConsultationParameters? params,
    ConsultationHomeData? homeData,
    LoadStatusEnum? getConsultationsStatus,
    LoadStatusEnum? addConsultationStatus,
    String? error,
  }) {
    return ConsultationState(
      params: params ?? this.params,
      homeData: homeData ?? this.homeData,
      consultations: consultations ?? this.consultations,
      getConsultationsStatus:
          getConsultationsStatus ?? this.getConsultationsStatus,
      addConsultationStatus:
          addConsultationStatus ?? this.addConsultationStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    consultations,
    params,
    homeData,
    getConsultationsStatus,
    addConsultationStatus,
    error,
  ];
}
