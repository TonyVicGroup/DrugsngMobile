import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/home/domain/models/home_data.dart';
import 'package:flutter/services.dart';

class HomeDatasource {
  final RestService service = RestService(baseUrl: AppUtils.baseUrl);

  Future<HomeData> getData() async {
    final response = await service.get(path: 'product/home-page');
    if (response.hasError) throw response.error;

    final data = response.data!['data'] as Map<String, dynamic>;

    // Extracts ads banner from assets for now
    final localData = await rootBundle.loadString(
      "assets/json/home_page_data.json",
    );
    final mapData = Map<String, dynamic>.from(json.decode(localData));
    data.addAll({HomeData.homeAdsKey: mapData[HomeData.homeAdsKey]});

    return HomeData.fromJson(data);
  }

  Future<String> getCountry() async {
    try {
      final cacheOptions = CacheOptions(
        store: MemCacheStore(),
        policy: CachePolicy.request,
        maxStale: const Duration(days: 7),
        priority: CachePriority.normal,
      );
      final dio =
          Dio()..interceptors.add(DioCacheInterceptor(options: cacheOptions));
      final response = await dio.get('http://ip-api.com/json');
      if (response.statusCode != 200) {
        throw ApiError(message: 'Could not get location data');
      }
      Map<String, dynamic> ispData = response.data;
      final country = ispData['country'];
      return country;
    } catch (e) {
      throw ApiError.unknown;
    }
  }
}
