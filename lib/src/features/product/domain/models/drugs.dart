import 'package:drugs_ng/src/features/product/domain/models/product.dart';

class Drug extends Product {
  // "id": 0,
  // "name": "string",
  // "price": 0,
  // "description": "string",
  // "genericNameId": 0,
  // "genericName": "string",
  // "brandId": 0,
  // "brandName": "string",
  // "productImageUrls": [
  //   "string"
  // ]

  // "deliveryTime": 0,
  // "dosage": "string",
  // "warning": "string",
  // "size": "string",
  // "quantity": 0,
  // "bannerUrl": "string",
  // "nonReturnable": true,
  // "productFormId": 0,
  // "productFormName": "string",
  // "categoryId": 0,
  // "categoryName": "string",
  // "subCategoryId": 0,
  // "subCategory": "string",
  // "reviews": [
  //   {
  //     "id": 0,
  //     "userId": 0,
  //     "userName": "string",
  //     "reviewComment": "string"
  //   }
  // ],

  /// model for product category in homepage

  factory Drug.fromJson(Map json) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
        ...super.props,
      ];
}
