import 'package:equatable/equatable.dart';

class Product extends Equatable {
  static const String _idKey = "id";
  static const String _nameKey = "name";
  static const String _brandNameKey = "brandName";
  static const String _genericNameKey = "genericName";
  static const String _descriptionKey = "description";
  static const String _priceKey = "price";
  static const String _tagIdKey = "tagId";
  static const String _productImageUrlsKey = "productImageUrls";

  // "id": 3,
  // "name": "Tutolin Expectorant",
  // "brandName": "Benadryl",
  // "genericName": "Paracetamol",
  // "description": "This is the description for expectorant",
  // "price": 10000,
  // "tagId": 1,
  // "productImageUrls": [
  //   "https://mushastorage.blob.core.windows.net/images/ccc1c2ab62120724085225TUTOLIN-rotated.jpg"
  // ]

  final int id;
  final String name, brandName, genericName;
  final String description;
  final double price;
  final int tagId;
  final List<String> imageUrls;

  const Product({
    required this.id,
    required this.name,
    required this.brandName,
    required this.genericName,
    required this.description,
    required this.price,
    required this.tagId,
    required this.imageUrls,
  });

  /// model for product category in homepage

  factory Product.fromJson(Map json) {
    return Product(
      id: json[_idKey],
      name: json[_nameKey],
      brandName: json[_brandNameKey],
      genericName: json[_genericNameKey],
      description: json[_descriptionKey],
      price: json[_priceKey],
      tagId: json[_tagIdKey],
      imageUrls: List<String>.from(json[_productImageUrlsKey]),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        brandName,
        genericName,
        description,
        price,
        tagId,
        imageUrls,
      ];
}
