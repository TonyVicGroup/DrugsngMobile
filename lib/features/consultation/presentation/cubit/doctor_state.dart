part of 'doctor_cubit.dart';

abstract class DoctorState extends Equatable {
  final List<Doctor> doctors;
  final DoctorParameters parameters;

  const DoctorState({
    required this.doctors,
    required this.parameters,
  });

  bool get hasFilter {
    return (parameters.rating != null) ||
        (parameters.searchTerm?.isNotEmpty ?? false);
  }

  @override
  List<Object> get props => [
        doctors,
        parameters,
      ];
}

class DoctorStateInitial extends DoctorState {
  DoctorStateInitial()
      : super(
          doctors: [],
          parameters: DoctorParameters.initial(),
        );
}

class DoctorStateLoading extends DoctorState {
  const DoctorStateLoading({
    required super.doctors,
    required super.parameters,
  });
}

class DoctorStateSuccess extends DoctorState {
  const DoctorStateSuccess({
    required super.doctors,
    required super.parameters,
  });
}

class DoctorStateError extends DoctorState {
  final AppError error;

  const DoctorStateError({
    required this.error,
    required super.doctors,
    required super.parameters,
  });

  @override
  List<Object> get props => [
        error,
        doctors,
        parameters,
      ];
}
