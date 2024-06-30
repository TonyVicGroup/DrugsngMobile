import 'package:equatable/equatable.dart';

class Product extends Equatable {
  static const String _nameKey = "name";
  static const String _imageKey = "image";
  static const String _categoryKey = "category";
  static const String _ratingKey = "rating";
  static const String _ratingCountKey = "ratingCount";
  static const String _priceKey = "price";
  static const String _prevPriceKey = "prevPrice";
  static const String _discountPercentKey = "discountPercent";

  final String name;
  final String image;
  final String category;
  final int rating;
  final int ratingCount;
  final double price;
  final double? prevPrice;
  final int? discountPercent;

  /// model for product category in homepage
  Product({
    required this.name,
    required this.image,
    required this.category,
    required this.rating,
    required this.ratingCount,
    required this.price,
    required this.prevPrice,
    required this.discountPercent,
  });

  factory Product.fromJson(Map json) {
    return Product(
      name: json[_nameKey],
      image: json[_imageKey],
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
        image,
        category,
        rating,
        ratingCount,
        price,
        prevPrice,
        discountPercent,
      ];
}
