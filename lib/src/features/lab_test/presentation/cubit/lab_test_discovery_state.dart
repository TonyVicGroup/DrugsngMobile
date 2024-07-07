part of 'lab_test_discovery_cubit.dart';

abstract class LabTestDiscoveryState extends Equatable {
  final List<DiagnosticTest> tests;
  final List<TestPackage> packages;
  const LabTestDiscoveryState(this.tests, this.packages);

  @override
  List<Object> get props => [tests, packages];
}

class LabTestDiscoveryInitial extends LabTestDiscoveryState {
  LabTestDiscoveryInitial() : super([], []);
}

class LabTestDiscoverySuccess extends LabTestDiscoveryState {
  const LabTestDiscoverySuccess(super.tests, super.packages);
}

class LabTestDiscoveryLoading extends LabTestDiscoveryState {
  const LabTestDiscoveryLoading(super.tests, super.packages);
}

class LabTestDiscoveryFailed extends LabTestDiscoveryState {
  final String message;
  const LabTestDiscoveryFailed(super.tests, super.packages, this.message);

  @override
  List<Object> get props => [tests, packages, message];
}
