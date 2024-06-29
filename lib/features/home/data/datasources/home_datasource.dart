import 'dart:convert';

import 'package:drugs_ng/features/home/data/models/home_data.dart';
import 'package:drugs_ng/features/home/domain/repositories/home_datasource.dart';
import 'package:flutter/services.dart';

class HomeLocalDatasource extends HomeDatasource {
  @override
  Future<HomeData> getData() async {
    final data = await rootBundle.loadString("assets/json/home_page_data.json");
    final mapData = Map<String, dynamic>.from(json.decode(data));
    return HomeData.fromJson(mapData);
  }
}
