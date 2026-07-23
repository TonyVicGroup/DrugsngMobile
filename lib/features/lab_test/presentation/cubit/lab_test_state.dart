part of 'lab_test_cubit.dart';

class LabTestState extends Equatable {
  final List<WellnessPackage> wellnessPackages;
  final List<DiagnosticTest> diagnosticTests;
  final List<HomeAds> ads;
  final int wellnessPageNumber;
  final int diagnosticPageNumber;
  final LoadStatusEnum diagnosticStatus;
  final LoadStatusEnum wellnessStatus;
  final LoadStatusEnum adStatus;
  final AppError? wellnessError;
  final AppError? diagnosticError;
  final bool testTab;

  const LabTestState({
    required this.ads,
    required this.wellnessPackages,
    required this.diagnosticTests,
    required this.wellnessPageNumber,
    required this.diagnosticPageNumber,
    required this.diagnosticStatus,
    required this.adStatus,
    required this.wellnessStatus,
    this.testTab = true,
    this.diagnosticError,
    this.wellnessError,
  });

  factory LabTestState.initial() => const LabTestState(
    ads: [],
    wellnessPackages: [],
    diagnosticTests: [],
    wellnessPageNumber: 0,
    diagnosticPageNumber: 0,
    diagnosticStatus: LoadStatusEnum.initial,
    wellnessStatus: LoadStatusEnum.initial,
    adStatus: LoadStatusEnum.initial,
  );

  bool get isEmpty => wellnessPackages.isEmpty && diagnosticTests.isEmpty;
  bool get loadFailed => diagnosticStatus.isFailed && wellnessStatus.isFailed;

  LabTestState copy({
    List<HomeAds>? ads,
    List<WellnessPackage>? wellnessPackages,
    List<DiagnosticTest>? diagnosticTests,
    int? wellnessPageNumber,
    int? diagnosticPageNumber,
    LoadStatusEnum? diagnosticStatus,
    LoadStatusEnum? wellnessStatus,
    LoadStatusEnum? adStatus,
    AppError? wellnessError,
    AppError? diagnosticError,
    bool? testTab,
  }) => LabTestState(
    ads: ads ?? this.ads,
    wellnessPackages: wellnessPackages ?? this.wellnessPackages,
    diagnosticTests: diagnosticTests ?? this.diagnosticTests,
    wellnessPageNumber: wellnessPageNumber ?? this.wellnessPageNumber,
    diagnosticPageNumber: diagnosticPageNumber ?? this.diagnosticPageNumber,
    adStatus: adStatus ?? this.adStatus,
    diagnosticStatus: diagnosticStatus ?? this.diagnosticStatus,
    wellnessStatus: wellnessStatus ?? this.wellnessStatus,
    testTab: testTab ?? this.testTab,
    wellnessError: wellnessError,
    diagnosticError: diagnosticError,
  );

  @override
  List<Object> get props => [
    wellnessPackages,
    diagnosticTests,
    wellnessPageNumber,
    ads,
    adStatus,
    diagnosticPageNumber,
    diagnosticStatus,
    wellnessStatus,
    testTab,
    diagnosticError ?? "",
    wellnessError ?? "",
  ];
}
