import 'package:drugs_ng/src/features/home/data/models/home_data.dart';

abstract class HomeDatasource {
  Future<HomeData> getData();
}
