import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/features/home/data/datasource/home_datasource.dart';
import 'package:drugs_ng/features/home/domain/models/home_data.dart';
import 'package:drugs_ng/features/product/data/datasources/product_datasource.dart';
import 'package:either_dart/either.dart';

class HomeRepository {
  final HomeDatasource datasource = HomeDatasource();

  // AsyncApiErrorOr<HomeData> getData() async {
  //   try {
  //     final response = await datasource.getData();
  //     return Right(response);
  //   } on ApiError catch (e) {
  //     return Left(e);
  //   } catch (e) {
  //     return const Left(ApiError.unknown);
  //   }
  // }

  AsyncApiErrorOr<String> getCountry() async {
    try {
      final response = await datasource.getCountry();
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
