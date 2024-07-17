import 'dart:convert';

import 'package:drugs_ng/src/core/data/models/product_detail.dart';
import 'package:drugs_ng/src/features/explore/domain/models/major_category.dart';
import 'package:drugs_ng/src/features/explore/domain/repository/explore_datasource.dart';
import 'package:flutter/services.dart';

class ExploreDatasourceLocal extends ExploreDatasource {
  @override
  Future<List<ProductDetail>> loadDrugCategory() async {
    await Future.delayed(const Duration(seconds: 3));
    final data = await rootBundle.loadString("assets/json/explore_data.json");
    final mapData = Map<String, dynamic>.from(json.decode(data));
    List<ProductDetail> products =
        List<Map<String, dynamic>>.from(mapData["general_health"])
            .map<ProductDetail>((dt) => ProductDetail.fromJson(dt))
            .toList();
    return products;
  }

  @override
  Future<List<ProductDetail>> loadHealthCareCategory() async {
    await Future.delayed(const Duration(seconds: 3));
    final data = await rootBundle.loadString("assets/json/explore_data.json");
    final mapData = Map<String, dynamic>.from(json.decode(data));
    List<ProductDetail> products =
        List<Map<String, dynamic>>.from(mapData["general_health"])
            .map<ProductDetail>((dt) => ProductDetail.fromJson(dt))
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

  @override
  Future<MajorCategoryData> getMajorCategories() async {
    return const MajorCategoryData(drugCategory: [], healthCareCategory: []);
  }
}
