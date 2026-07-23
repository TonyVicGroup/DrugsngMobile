import 'package:equatable/equatable.dart';

class DiagnosticTest extends Equatable {
  static const String _idKey = "id";
  static const String _nameKey = "name";
  static const String _descriptionKey = "description";
  static const String _durationKey = "duration";
  static const String _priceKey = "price";
  static const String _imageUrlsKey = "imageUrls";

  final int id;
  final String name;
  final String description;
  final String duration;
  final double price;
  final String? imageUrls;

  const DiagnosticTest({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.price,
    required this.imageUrls,
  });

  factory DiagnosticTest.fromJson(Map json) {
    num priceNum = json[_priceKey];
    return DiagnosticTest(
      id: json[_idKey],
      name: json[_nameKey] ?? "",
      description: json[_descriptionKey] ?? "",
      duration: json[_durationKey] ?? "",
      price: priceNum.toDouble(),
      imageUrls: json[_imageUrlsKey],
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
      ];
}
