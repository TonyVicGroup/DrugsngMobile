import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor_details.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor_parameters.dart';
import 'package:drugs_ng/features/doctor/data/repositories/doctor_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final DoctorRepository repo = DoctorRepository();

  DoctorCubit() : super(DoctorStateInitial());

  Future<void> getDoctors({bool showLoader = true}) async {
    final result = await repo.getDoctors(state.parameters);
    if (showLoader) {
      emit(
        DoctorStateLoading(
          doctors: state.doctors,
          parameters: state.parameters,
        ),
      );
    }
    result.fold(
      (left) {
        emit(
          DoctorStateError(
            error: left,
            doctors: state.doctors,
            parameters: state.parameters,
          ),
        );
      },
      (right) {
        emit(
          DoctorStateSuccess(
            doctors: right,
            parameters: state.parameters.copy(pageNumber: 1),
          ),
        );
      },
    );
  }

  void setService(String service) {
    emit(
      DoctorStateSuccess(
        doctors: state.doctors,
        parameters: state.parameters.copy(speciality: service),
      ),
    );
  }

  void clearFilter() {
    emit(
      DoctorStateSuccess(
        doctors: state.doctors,
        parameters: DoctorParameters.initial(),
      ),
    );
    findDoctor();
  }

  void setRating(int rating) {
    emit(
      DoctorStateSuccess(
        doctors: state.doctors,
        parameters: state.parameters.copy(rating: rating),
      ),
    );
  }

  Future<void> findDoctor([String? query]) async {
    emit(
      DoctorStateLoading(doctors: state.doctors, parameters: state.parameters),
    );
    final result = await repo.getDoctors(state.parameters);
    result.fold(
      (left) {
        emit(
          DoctorStateError(
            error: left,
            doctors: state.doctors,
            parameters: state.parameters,
          ),
        );
      },
      (right) {
        emit(DoctorStateSuccess(doctors: right, parameters: state.parameters));
      },
    );
  }

  Future<(DoctorDetails?, String)> getSingleDoctor(int id) async {
    final result = await repo.getDoctor(id);
    if (result.isRight) {
      return (result.right, '');
    } else {
      return (null, result.left.message);
    }
  }
}
