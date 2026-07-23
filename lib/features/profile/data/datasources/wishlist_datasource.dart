import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:drugs_ng/features/profile/data/models/wishlist.dart';

class WishlistDatasource {
  final RestService service = RestService(baseUrl: AppUtils.baseUrl);

  Future<List<Wishlist>> getWishlist(PageFilter pageFilter) async {
    final response = await service.get(
      path: 'wish-list/user',
      params: pageFilter.toJson(),
    );

    if (response.hasError) throw response.error;

    final iterable = List.from(
      response.data!['data']['items'] ?? [],
    ).map((hist) => Wishlist.fromJson(hist));

    return iterable.toList();
  }

  Future<String> addWishlist(int id, String itemType) async {
    final response = await service.post(
      path: 'wish-list/add',
      data: {'itemId': id, 'itemType': itemType},
    );
    if (response.hasError) throw response.error;

    return response.data!['responseMessage'] as String;
  }

  Future<String> removeWishlist(int id, String itemType) async {
    final response = await service.put(
      path: 'wish-list/remove',
      data: {'itemId': id, 'itemType': itemType},
    );
    if (response.hasError) throw response.error;
    return response.data!['responseMessage'] as String;
  }
}
