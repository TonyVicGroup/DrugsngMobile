import 'package:drugs_ng/features/home/data/models/home_data.dart';

abstract class HomeDatasource {
  Future<HomeData> getData();
}
