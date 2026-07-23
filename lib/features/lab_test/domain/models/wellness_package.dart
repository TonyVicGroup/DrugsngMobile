// import 'package:drugs_ng/src/features/lab_test/domain/models/purpose_data.dart';
// import 'package:drugs_ng/src/features/lab_test/domain/models/test_data.dart';
import 'package:equatable/equatable.dart';

class WellnessPackage extends Equatable {
  static const String _idKey = "id";
  static const String _nameKey = "name";
  static const String _descriptionKey = "description";
  static const String _priceKey = "price";
  static const String _resultTimeKey = "resultTime";
  static const String _oldPriceKey = "oldPrice";
  static const String _discountPercentageKey = "discountPercentage";
  static const String _imageUrlKey = "imageUrl";
  // static const String _durationKey = "duration";

  final int id;
  final String name;
  final String description;
  final String resultTime;
  final double price;
  final double? oldPrice;
  final double? discountPercentage;
  final String imageUrl;
  // final String duration;

  const WellnessPackage({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    // required this.duration,
    required this.resultTime,
    required this.oldPrice,
    required this.discountPercentage,
    required this.imageUrl,
  });

  factory WellnessPackage.fromJson(Map json) {
    num number = json[_priceKey];
    num? oldPrice = json[_oldPriceKey];
    num? discountPercent = json[_discountPercentageKey];
    return WellnessPackage(
      id: json[_idKey],
      name: json[_nameKey] ?? "",
      description: json[_descriptionKey] ?? "",
      price: number.toDouble(),
      resultTime: json[_resultTimeKey].toString(),
      oldPrice: oldPrice?.toDouble(),
      discountPercentage: discountPercent?.toDouble(),
      imageUrl: json[_imageUrlKey] ?? "",
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    resultTime,
    oldPrice,
    discountPercentage,
    imageUrl,
  ];
}
