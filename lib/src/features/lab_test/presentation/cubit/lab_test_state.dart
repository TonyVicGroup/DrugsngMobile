part of 'lab_test_cubit.dart';

abstract class LabTestState extends Equatable {
  final LabTestHome data;
  const LabTestState(this.data);

  @override
  List<Object> get props => [data];
}

class LabTestInitial extends LabTestState {
  const LabTestInitial()
      : super(const LabTestHome(tests: [], packages: [], ads: []));
}

class LabTestLoading extends LabTestState {
  const LabTestLoading(super.data);
}

class LabTestSuccess extends LabTestState {
  const LabTestSuccess(super.data);
}

class LabTestError extends LabTestState {
  final String message;
  const LabTestError(super.data, this.message);

  @override
  List<Object> get props => [message, data];
}
