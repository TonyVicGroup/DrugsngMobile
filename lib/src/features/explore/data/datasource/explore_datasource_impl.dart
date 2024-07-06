import 'dart:convert';

import 'package:drugs_ng/src/features/explore/domain/repository/explore_datasource.dart';
import 'package:drugs_ng/src/features/home/domain/product.dart';
import 'package:flutter/services.dart';

class ExploreDatasourceImpl extends ExploreDatasource {
  @override
  Future<List<Product>> loadCategory(String category) async {
    await Future.delayed(const Duration(seconds: 3));
    final data = await rootBundle.loadString("assets/json/explore_data.json");
    final mapData = Map<String, dynamic>.from(json.decode(data));
    List<Product> products =
        List<Map<String, dynamic>>.from(mapData["general_health"])
            .map<Product>((dt) => Product.fromJson(dt))
            .toList();
    return products;
  }

  @override
  Future<List<String>> getBrandNames(String category) async {
    await Future.delayed(const Duration(seconds: 3));
    return [
      "Benadryl",
      "Smile",
      "Try",
      "To",
      "Think",
      "of",
      "a",
      "brand",
      "name"
    ];
  }

  @override
  Future<List<String>> getSubcategories(String category) async {
    await Future.delayed(const Duration(seconds: 3));
    return [
      "Benadryl",
      "Smile",
      "Try",
      "To",
      "Think",
      "of",
      "a",
      "brand",
      "name"
    ];
  }
}
