import 'dart:convert';

import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:drugs_ng/src/core/utils/app_data_types.dart';
import 'package:drugs_ng/src/core/utils/rest_service.dart';
import 'package:drugs_ng/src/features/home/domain/models/home_data.dart';
import 'package:drugs_ng/src/features/home/domain/repositories/home_repository.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/services.dart';

class HomeRepositoryImpl extends HomeRepository {
  final RestService service;
  HomeRepositoryImpl(this.service);

  @override
  AsyncApiErrorOr<HomeData> getData() async {
    try {
      final response = await service.get(path: 'product/home-page');
      if (response.hasError) return Left(response.error);

      final data = response.data!['data'] as Map<String, dynamic>;

      // Extracts ads banner from assets for now
      {
        final localData = await rootBundle.loadString(
          "assets/json/home_page_data.json",
        );
        final mapData = Map<String, dynamic>.from(json.decode(localData));
        data.addAll({HomeData.homeAdsKey: mapData[HomeData.homeAdsKey]});
      }

      return Right(HomeData.fromJson(data));
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
