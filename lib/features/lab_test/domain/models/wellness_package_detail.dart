import 'package:drugs_ng/features/lab_test/domain/models/laboratory_data.dart';
import 'package:drugs_ng/features/lab_test/domain/models/purpose_data.dart';
import 'package:drugs_ng/features/lab_test/domain/models/test_data.dart';
import 'package:equatable/equatable.dart';

class WellnessPackageDetail extends Equatable {
  static const String _idKey = "id";
  static const String _nameKey = "name";
  static const String _descriptionKey = "description";
  static const String _priceKey = "price";
  static const String _oldPriceKey = "oldPrice";
  static const String _discountPercentageKey = "discountPercentage";
  static const String _imageUrlKey = "imageUrl";
  static const String _labouratoriesKey = "labouratories";
  static const String _durationKey = "duration";
  static const String _resultTimeKey = "resultTime";
  static const String _testsKey = "tests";
  static const String _purposesKey = "purposes";

  final int id;
  final String name;
  final String description;
  final double price;
  final double oldPrice;
  final double discountPercentage;
  final String? imageUrl;
  final List<LaboratoryData> laboratories;
  final String duration;
  final String resultTime;
  final List<TestData> tests;
  final List<PurposeData> purposes;

  const WellnessPackageDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.oldPrice,
    required this.discountPercentage,
    required this.imageUrl,
    required this.laboratories,
    required this.duration,
    required this.resultTime,
    required this.tests,
    required this.purposes,
  });

  factory WellnessPackageDetail.fromJson(Map json) {
    num number = json[_priceKey];
    num discountPercentage = json[_discountPercentageKey];
    num oldPrice = json[_oldPriceKey];
    return WellnessPackageDetail(
      id: json[_idKey],
      name: json[_nameKey] ?? "",
      description: json[_descriptionKey] ?? "",
      price: number.toDouble(),
      oldPrice: oldPrice.toDouble(),
      imageUrl: json[_imageUrlKey],
      discountPercentage: discountPercentage.toDouble(),
      duration: json[_durationKey].toString(),
      resultTime: json[_resultTimeKey],
      laboratories:
          List.from(
            json[_labouratoriesKey],
          ).map((tst) => LaboratoryData.fromJson(tst)).toList(),
      tests:
          List.from(
            json[_testsKey],
          ).map((tst) => TestData.fromJson(tst)).toList(),
      purposes:
          List.from(
            json[_purposesKey],
          ).map((pur) => PurposeData.fromJson(pur)).toList(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    oldPrice,
    discountPercentage,
    imageUrl,
    laboratories,
    duration,
    resultTime,
    tests,
    purposes,
  ];
}
