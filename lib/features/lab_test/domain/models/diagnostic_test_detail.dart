import 'package:drugs_ng/features/lab_test/domain/models/benefit_data.dart';
import 'package:drugs_ng/features/lab_test/domain/models/component_data.dart';
import 'package:drugs_ng/features/lab_test/domain/models/laboratory_data.dart';
import 'package:drugs_ng/features/lab_test/domain/models/purpose_data.dart';
import 'package:drugs_ng/features/lab_test/domain/models/sample_data.dart';
import 'package:equatable/equatable.dart';

class DiagnosticTestDetail extends Equatable {
  static const String _idKey = "id";
  static const String _nameKey = "name";
  static const String _descriptionKey = "description";
  static const String _durationKey = "duration";
  static const String _priceKey = "price";
  static const String _imageUrlsKey = "imageUrls";
  static const String _testTypeIdKey = "testTypeId";
  static const String _labouratoriesKey = "labouratories";
  static const String _benefitsKey = "benefits";
  static const String _componentsKey = "components";
  static const String _purposesKey = "purposes";
  static const String _samplesKey = "samples";

  final int id;
  final String name;
  final String description;
  final String duration;
  final double price;
  final String? imageUrls;
  final int? testTypeId;
  final List<LaboratoryData> labouratories;
  final List<BenefitData> benefits;
  final List<ComponentData> components;
  final List<PurposeData> purposes;
  final List<SampleData> samples;

  const DiagnosticTestDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.price,
    required this.imageUrls,
    required this.testTypeId,
    required this.labouratories,
    required this.benefits,
    required this.components,
    required this.purposes,
    required this.samples,
  });

  factory DiagnosticTestDetail.fromJson(Map json) {
    num priceNum = json[_priceKey];
    return DiagnosticTestDetail(
      id: json[_idKey],
      name: json[_nameKey] ?? "",
      description: json[_descriptionKey] ?? "",
      duration: json[_durationKey] ?? "",
      price: priceNum.toDouble(),
      imageUrls: json[_imageUrlsKey],
      testTypeId: json[_testTypeIdKey],
      labouratories:
          List.from(
            json[_labouratoriesKey],
          ).map<LaboratoryData>((lab) => LaboratoryData.fromJson(lab)).toList(),
      benefits:
          List.from(
            json[_benefitsKey],
          ).map<BenefitData>((lab) => BenefitData.fromJson(lab)).toList(),
      components:
          List.from(
            json[_componentsKey],
          ).map<ComponentData>((lab) => ComponentData.fromJson(lab)).toList(),
      purposes:
          List.from(
            json[_purposesKey],
          ).map<PurposeData>((lab) => PurposeData.fromJson(lab)).toList(),
      samples:
          List.from(
            json[_samplesKey],
          ).map<SampleData>((lab) => SampleData.fromJson(lab)).toList(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    duration,
    price,
    imageUrls,
    testTypeId,
    labouratories,
    benefits,
    components,
    purposes,
    samples,
  ];
}
