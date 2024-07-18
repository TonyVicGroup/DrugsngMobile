part of 'lab_test_discovery_cubit.dart';

class LabTestDiscoveryState extends Equatable {
  final List<DiagnosticTest> tests;
  final Status testStatus;
  final List<TestPackage> packages;
  final Status packageStatus;
  final bool testTab;

  const LabTestDiscoveryState(
    this.tests,
    this.packages,
    this.testStatus,
    this.packageStatus,
    this.testTab,
  );

  factory LabTestDiscoveryState.initial() {
    return const LabTestDiscoveryState(
        [], [], Status.initial, Status.initial, true);
  }

  LabTestDiscoveryState copy({
    List<DiagnosticTest>? tests,
    Status? testStatus,
    List<TestPackage>? packages,
    Status? packageStatus,
    bool? testTab,
  }) =>
      LabTestDiscoveryState(
        tests ?? this.tests,
        packages ?? this.packages,
        testStatus ?? this.testStatus,
        packageStatus ?? this.packageStatus,
        testTab ?? this.testTab,
      );

  @override
  List<Object> get props =>
      [tests, packages, testStatus, packageStatus, testTab];
}

// class LabTestDiscoveryInitial extends LabTestDiscoveryState {
//   LabTestDiscoveryInitial() : super([], [], Status.initial, Status.initial);
// }

// class LabTestDiscoverySuccess extends LabTestDiscoveryState {
//   const LabTestDiscoverySuccess(
//       super.tests, super.packages, super.testStatus, super.packageStatus);
// }

// class LabTestDiscoveryLoading extends LabTestDiscoveryState {
//   const LabTestDiscoveryLoading(
//       super.tests, super.packages, super.testStatus, super.packageStatus);
// }

// class LabTestDiscoveryFailed extends LabTestDiscoveryState {
//   final String message;

//   const LabTestDiscoveryFailed(super.tests, super.packages, super.testStatus,
//       super.packageStatus, this.message);

//   @override
//   List<Object> get props =>
//       [tests, packages, testStatus, packageStatus, message];
// }
