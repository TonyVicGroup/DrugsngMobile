import 'package:drugs_ng/src/core/data/models/review.dart';
import 'package:equatable/equatable.dart';

class ProductDetail extends Equatable {
  static const String _idKey = "id";
  static const String _priceKey = "price";
  static const String _nameKey = "name";
  static const String _descriptionKey = "description";
  static const String _deliveryTimeKey = "deliveryTime";
  static const String _dosageKey = "dosage";
  static const String _warningKey = "warning";
  static const String _sizeKey = "size";
  static const String _quantityKey = "quantity";
  static const String _bannerUrlKey = "bannerUrl";
  static const String _nonReturnableKey = "nonReturnable";
  static const String _productFormIdKey = "productFormId";
  static const String _productFormNameKey = "productFormName";
  static const String _genericNameIdKey = "genericNameId";
  static const String _genericNameKey = "genericName";
  static const String _categoryIdKey = "categoryId";
  static const String _categoryNameKey = "categoryName";
  static const String _subCategoryIdKey = "subCategoryId";
  static const String _subCategoryKey = "subCategory";
  static const String _brandIdKey = "brandId";
  static const String _brandNameKey = "brandName";
  static const String _reviewsKey = "reviews";
  static const String _productImageKey = "productImageUrls";

  final int id;
  final String name;
  final double price;
  final String description;
  final DateTime deliveryTime;
  final String dosage;
  final String warning;
  final String size;
  final int quantity;
  final String? bannerUrl;
  final bool nonReturnable;
  final int productFormId;
  final String productFormName;
  final int genericNameId;
  final String genericName;
  final int categoryId;
  final String categoryName;
  final int subCategoryId;
  final String subCategory;
  final int brandId;
  final String brandName;
  final List<Review> reviews;
  final List<String> imageUrls;

  const ProductDetail({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.deliveryTime,
    required this.dosage,
    required this.warning,
    required this.size,
    required this.quantity,
    required this.bannerUrl,
    required this.nonReturnable,
    required this.productFormId,
    required this.productFormName,
    required this.genericNameId,
    required this.genericName,
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryId,
    required this.subCategory,
    required this.brandId,
    required this.brandName,
    required this.reviews,
    required this.imageUrls,
  });

  factory ProductDetail.fromJson(Map json) {
    return ProductDetail(
      id: json[_idKey],
      name: json[_nameKey],
      price: json[_priceKey],
      description: json[_descriptionKey],
      deliveryTime: DateTime.fromMillisecondsSinceEpoch(json[_deliveryTimeKey]),
      dosage: json[_dosageKey],
      warning: json[_warningKey],
      size: json[_sizeKey],
      quantity: json[_quantityKey],
      bannerUrl: json[_bannerUrlKey],
      nonReturnable: json[_nonReturnableKey],
      productFormId: json[_productFormIdKey],
      productFormName: json[_productFormNameKey],
      genericNameId: json[_genericNameIdKey],
      genericName: json[_genericNameKey],
      categoryId: json[_categoryIdKey],
      categoryName: json[_categoryNameKey],
      subCategoryId: json[_subCategoryIdKey],
      subCategory: json[_subCategoryKey],
      brandId: json[_brandIdKey],
      brandName: json[_brandNameKey],
      reviews: List.from(json[_reviewsKey])
          .map<Review>((r) => Review.fromJson(r))
          .toList(),
      imageUrls: List<String>.from(json[_productImageKey]),
    );
  }

  @override
  List<Object?> get props => [
        id,
        price,
        name,
        description,
        deliveryTime,
        dosage,
        warning,
        size,
        quantity,
        bannerUrl,
        nonReturnable,
        productFormId,
        productFormName,
        genericNameId,
        genericName,
        categoryId,
        categoryName,
        subCategoryId,
        subCategory,
        brandId,
        brandName,
        reviews,
        imageUrls
      ];
}
