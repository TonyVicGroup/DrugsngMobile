import 'dart:convert';

import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:drugs_ng/src/core/utils/app_data_types.dart';
import 'package:drugs_ng/src/features/home/data/models/home_data.dart';
import 'package:drugs_ng/src/features/home/domain/repositories/home_repository.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/services.dart';

class HomeRepositoryLocal extends HomeRepository {
  @override
  AsyncApiErrorOr<HomeData> getData() async {
    try {
      final data = await rootBundle.loadString(
        "assets/json/home_page_data.json",
      );
      final mapData = Map<String, dynamic>.from(json.decode(data));
      return Right(HomeData.fromJson(mapData));
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
