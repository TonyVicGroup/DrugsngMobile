import 'package:drugs_ng/core/enum/item_type_enum.dart';
import 'package:equatable/equatable.dart';

class Wishlist extends Equatable {
  static const String _itemIdKey = "itemId";
  static const String _itemTypeKey = "itemType";
  static const String _nameKey = "name";
  static const String _priceKey = "price";
  static const String _oldPriceKey = "oldPrice";
  static const String _brandIdKey = "brandId";
  static const String _brandNameKey = "brandName";
  static const String _discountPercentageKey = "discountPercentage";
  static const String _averageRatingKey = "averageRating";
  static const String _tagIdKey = "tagId";
  static const String _productImageUrlsKey = "productImageUrls";

  final int itemId;
  final ItemTypeEnum itemType;
  final String name;
  final double price;
  final double? oldPrice;
  final int? brandId;
  final String? brandName;
  final double? discountPercentage;
  final double? averageRating;
  final int tagId;
  final List<String> productImageUrls;

  const Wishlist({
    required this.itemId,
    required this.itemType,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.brandId,
    required this.brandName,
    required this.discountPercentage,
    required this.averageRating,
    required this.tagId,
    required this.productImageUrls,
  });

  factory Wishlist.fromJson(Map json) {
    num? oldPriceNum = json[_oldPriceKey];
    num priceNum = json[_priceKey];
    num? discountPercentage = json[_discountPercentageKey];
    num? averageRating = json[_averageRatingKey];
    return Wishlist(
      itemId: json[_itemIdKey],
      itemType: ItemTypeEnum.fromString(json[_itemTypeKey]),
      name: json[_nameKey],
      price: priceNum.toDouble(),
      oldPrice: oldPriceNum?.toDouble(),
      brandId: json[_brandIdKey],
      brandName: json[_brandNameKey],
      discountPercentage: discountPercentage?.toDouble(),
      averageRating: averageRating?.toDouble(),
      tagId: json[_tagIdKey],
      productImageUrls: List<String>.from(json[_productImageUrlsKey]),
    );
  }

  @override
  List<Object?> get props => [
    itemId,
    itemType,
    name,
    price,
    oldPrice,
    brandId,
    brandName,
    discountPercentage,
    averageRating,
    tagId,
    productImageUrls,
  ];
}
