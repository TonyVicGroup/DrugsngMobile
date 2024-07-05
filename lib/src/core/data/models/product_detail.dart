import 'package:equatable/equatable.dart';

class ProductDetail extends Equatable {
  static const String _nameKey = "name";
  static const String _imageKey = "images";
  static const String _categoryKey = "category";
  static const String _ratingKey = "rating";
  static const String _ratingCountKey = "ratingCount";
  static const String _priceKey = "price";
  static const String _prevPriceKey = "prevPrice";
  static const String _discountPercentKey = "discountPercent";

  final String name;
  final List<String> images;
  final String category;
  final int rating;
  final int ratingCount;
  final double price;
  final double? prevPrice;
  final int? discountPercent;

  /// model for product category in homepage
  const ProductDetail({
    required this.name,
    required this.images,
    required this.category,
    required this.rating,
    required this.ratingCount,
    required this.price,
    required this.prevPrice,
    required this.discountPercent,
  });

  factory ProductDetail.fromJson(Map json) {
    return ProductDetail(
      name: json[_nameKey],
      images: List<String>.from(json[_imageKey]),
      category: json[_categoryKey],
      rating: json[_ratingKey],
      ratingCount: json[_ratingCountKey],
      price: json[_priceKey],
      prevPrice: json[_prevPriceKey],
      discountPercent: json[_discountPercentKey],
    );
  }

  @override
  List<Object?> get props => [
        name,
        images,
        category,
        rating,
        ratingCount,
        price,
        prevPrice,
        discountPercent,
      ];
}
