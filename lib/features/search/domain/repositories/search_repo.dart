import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/features/search/data/models/search_item.dart';

abstract class SearchRepo {
  AsyncApiErrorOr<List<SearchItem>> all(String query);
  AsyncApiErrorOr<List<SearchItem>> product(String query);
  AsyncApiErrorOr<List<SearchItem>> diagnosticTest(String query);
  AsyncApiErrorOr<List<SearchItem>> wellnessPackage(String query);
  AsyncApiErrorOr<List<SearchItem>> testAndPackage(String query);
}
