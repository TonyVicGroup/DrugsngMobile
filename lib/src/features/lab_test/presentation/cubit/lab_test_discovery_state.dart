part of 'lab_test_discovery_cubit.dart';

abstract class LabTestDiscoveryState extends Equatable {
  final List<DiagnosticTest> tests;
  final Status testStatus;
  final List<TestPackage> packages;
  final Status packageStatus;
  const LabTestDiscoveryState(
    this.tests,
    this.packages,
    this.testStatus,
    this.packageStatus,
  );

  @override
  List<Object> get props => [tests, packages];
}

class LabTestDiscoveryInitial extends LabTestDiscoveryState {
  LabTestDiscoveryInitial() : super([], [], Status.initial, Status.initial);
}

class LabTestDiscoverySuccess extends LabTestDiscoveryState {
  const LabTestDiscoverySuccess(
      super.tests, super.packages, super.testStatus, super.packageStatus);
}

class LabTestDiscoveryLoading extends LabTestDiscoveryState {
  const LabTestDiscoveryLoading(
      super.tests, super.packages, super.testStatus, super.packageStatus);
}

class LabTestDiscoveryFailed extends LabTestDiscoveryState {
  final String message;

  const LabTestDiscoveryFailed(super.tests, super.packages, super.testStatus,
      super.packageStatus, this.message);

  @override
  List<Object> get props =>
      [tests, packages, testStatus, packageStatus, message];
}
