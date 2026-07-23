import 'package:drugs_ng/core/services/location_service.dart';
import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/explore/domain/models/explore_filter.dart';
import 'package:drugs_ng/features/explore/domain/models/generic_brand_name.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:drugs_ng/features/explore/domain/models/sub_category.dart';
import 'package:drugs_ng/features/product/domain/models/product_detail.dart';
import 'package:drugs_ng/features/explore/domain/models/major_category.dart';

class ExploreDatasource {
  final RestService service = RestService(baseUrl: AppUtils.baseUrl);

  Future<({String latitude, String longitude})> _fetchLocation() async {
    try {
      final location = await LocationService.getCurrentLatLng();
      return (
        latitude: location.latitude.toString(),
        longitude: location.longitude.toString(),
      );
    } catch (e) {
      throw Exception('Failed to fetch location: $e');
    }
  }

  Future<List<ProductDetail>> loadDrugCategory(ExploreFilter filter) async {
    final location = await _fetchLocation();
    final response = await service.get(
      path: 'product/drugs',
      params: {
        ...filter.toJson(),
        'Latitude': location.latitude,
        'Longitude': location.longitude,
      },
    );
    if (response.hasError) throw response.error;
    return List<Map>.from(
      response.data!['data'],
    ).map((prod) => ProductDetail.fromJson(prod)).toList();
  }

  Future<List<ProductDetail>> loadHealthCareCategory(
    ExploreFilter filter,
  ) async {
    final location = await _fetchLocation();
    final response = await service.get(
      path: 'product/health-care',
      params: {
        ...filter.toJson(),
        'Latitude': location.latitude,
        'Longitude': location.longitude,
      },
    );
    if (response.hasError) throw response.error;
    return List<Map>.from(
      response.data!['data'],
    ).map((prod) => ProductDetail.fromJson(prod)).toList();
  }

  Future<List<GenericBrandName>> getBrandNames(PageFilter pageFilter) async {
    final response = await service.get(path: 'brand/brands');
    if (response.hasError) throw response.error;

    return List<Map>.from(
      response.data!['data'],
    ).map((e) => GenericBrandName.fromJson(e)).toList();
  }

  Future<List<GenericBrandName>> getGenericNames(PageFilter pageFilter) async {
    final response = await service.get(path: 'generic-name/generic-names');
    if (response.hasError) throw response.error;

    return List<Map>.from(
      response.data!['data'],
    ).map((e) => GenericBrandName.fromJson(e)).toList();
  }

  Future<List<SubCategory>> getSubcategories(
    int categoryId,
    PageFilter pageFilter,
  ) async {
    final response = await service.get(
      path: 'category/$categoryId/sub-categories',
      params: pageFilter.toJson(),
    );
    if (response.hasError) throw response.error;

    return List<Map>.from(
      response.data!['data'],
    ).map((e) => SubCategory.fromJson(e)).toList();
  }

  Future<MajorCategoryData> getMajorCategories() async {
    final response = await service.get(path: 'category/GetCategories');
    if (response.hasError) throw response.error;
    return MajorCategoryData.fromJson(response.data!['data']);
  }
}
