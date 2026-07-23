import 'package:drugs_ng/features/product/data/models/product_review.dart';
import 'package:drugs_ng/features/product/domain/models/review.dart';
import 'package:drugs_ng/features/profile/data/models/review.dart';
import 'package:equatable/equatable.dart';

class ProductDetail extends Equatable {
  final int id;
  final String name;
  final double price;
  final String description;
  final DateTime deliveryTime;
  final String dosage;
  final String warning;
  final String size;
  final int amountSold;
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
  final List<BriefReview> reviews;
  final List<String> imageUrls;
  final int quantity;
  final double oldPrice;
  final double discountPercentage;
  final double averageRating;
  final int? pharmacyId;

  const ProductDetail({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.deliveryTime,
    required this.dosage,
    required this.warning,
    required this.size,
    required this.amountSold,
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
    required this.quantity,
    required this.oldPrice,
    required this.discountPercentage,
    required this.averageRating,
    required this.pharmacyId,
  });

  factory ProductDetail.fromJson(Map json) {
    return ProductDetail(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      oldPrice: json["oldPrice"]?.toDouble() ?? 0.0,
      description: json["description"],
      deliveryTime: DateTime.fromMillisecondsSinceEpoch(json["deliveryTime"]),
      dosage: json["dosage"],
      warning: json["warning"],
      size: json["size"],
      quantity: json["quantity"],
      amountSold: json["amountSold"] ?? 1,
      bannerUrl: json["bannerUrl"],
      nonReturnable: json["nonReturnable"],
      productFormId: json["productFormId"],
      productFormName: json["productFormName"],
      genericNameId: json["genericNameId"],
      genericName: json["genericName"],
      categoryId: json["categoryId"],
      categoryName: json["category"],
      subCategoryId: json["subCategoryId"],
      subCategory: json["subCategory"],
      brandId: json["brandId"],
      brandName: json["brandName"],
      discountPercentage: json["discountPercentage"]?.toDouble() ?? 0.0,
      averageRating: json["averageRating"]?.toDouble() ?? 0.0,
      reviews:
          List.from(
            json["reviews"],
          ).map<BriefReview>((r) => BriefReview.fromJson(r)).toList(),
      imageUrls: List<String>.from(json["productImageUrls"]),
      pharmacyId: json["pharmacyId"],
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
    amountSold,
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
    imageUrls,
    quantity,
    oldPrice,
    discountPercentage,
    averageRating,
    pharmacyId,
  ];
}

class BriefReview extends Equatable {
  final int id;
  final int userId;
  final String userName;
  final String reviewComment;
  final double rating;

  const BriefReview({
    required this.id,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.reviewComment,
  });

  factory BriefReview.fromJson(Map json) {
    num ratingStar = json["rating"];
    return BriefReview(
      id: json["id"],
      userId: json["userId"],
      userName: json["userName"] ?? "",
      rating: ratingStar.toDouble(),
      reviewComment: json["reviewComment"],
    );
  }

  @override
  List<Object?> get props => [id, userId, userName, rating, reviewComment];
}
