import 'package:drugs_ng/src/core/utils/app_data_types.dart';
import 'package:drugs_ng/src/features/home/data/models/home_data.dart';

abstract class HomeRepository {
  AsyncApiErrorOr<HomeData> getData();
}
