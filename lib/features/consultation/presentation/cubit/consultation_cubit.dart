import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_data.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_details.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_home_data.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_parameters.dart';
import 'package:drugs_ng/features/consultation/data/repository/consultation_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'consultation_state.dart';

class ConsultationCubit extends Cubit<ConsultationState> {
  final ConsultationRepository repo = ConsultationRepository();
  ConsultationCubit() : super(ConsultationStateInitial());

  Future<void> getHomeData({bool refreshPage = true}) async {
    // refresh home page
    if (refreshPage) {
      emit(
        ConsultationStateLoading(
          state.consultations,
          state.params,
          state.homeData,
        ),
      );
    }
    final result = await repo.getHomeData();
    result.fold(
      (left) {
        emit(
          ConsultationStateError(
            left,
            state.consultations,
            state.params,
            state.homeData,
          ),
        );
      },
      (right) {
        emit(
          ConsultationStateSuccess(state.consultations, state.params, right),
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

  Future<AppError?> addConsultation(ConsultationData data) async {
    final result = await repo.addConsultation(data);
    if (result.isLeft) {
      return result.left;
    } else {
      return null;
    }
  }
}
