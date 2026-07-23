part of 'prescription_cubit.dart';

abstract class PrescriptionState extends Equatable {
  final List<Prescription> prescriptions;
  const PrescriptionState(this.prescriptions);

  @override
  List<Object> get props => [prescriptions];
}

class PrescriptionInitial extends PrescriptionState {
  const PrescriptionInitial() : super(const []);
}

class PrescriptionLoading extends PrescriptionState {
  const PrescriptionLoading(super.prescriptions);
}

class PrescriptionUploadLoading extends PrescriptionState {
  const PrescriptionUploadLoading(super.prescriptions);
}

class PrescriptionSuccess extends PrescriptionState {
  const PrescriptionSuccess(super.prescriptions);
}

class PrescriptionUploadSuccess extends PrescriptionState {
  const PrescriptionUploadSuccess(super.prescriptions);
}

class PrescriptionError extends PrescriptionState {
  final AppError error;
  const PrescriptionError(super.prescriptions, this.error);

  @override
  List<Object> get props => [error, prescriptions];
}
