import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/auth/data/datasource/get_local_token.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:drugs_ng/features/profile/data/models/debit_card.dart';
import 'package:drugs_ng/features/profile/data/models/order_detail_model.dart';
import 'package:drugs_ng/features/profile/data/models/order_history.dart';
import 'package:drugs_ng/features/profile/data/models/review.dart';

class ProfileDatasource {
  final RestService service = RestService(baseUrl: AppUtils.baseUrl);

  Future<List<OrderHistory>> getOrderHistory(
    PageFilter pageFilter,
    String status,
  ) async {
    final userId = UserPreference.getUser()!.userId;
    final params = pageFilter.toJson();
    final query = {
      "OrderState": status,
      "PageNumber": params["pageNumber"],
      "PageSize": params["pageSize"],
    };

    final response = await service.get(
      path: 'order/user/$userId',
      params: query,
    );
    if (response.hasError) throw response.error;
    final history = List.from(
      response.data!['data'],
    ).map((hist) => OrderHistory.fromJson(hist));
    return history.toList();
  }

  Future<OrderDetailModel> getOrderDetails(int orderId) async {
    final response = await service.get(path: 'order/order/$orderId');
    if (response.hasError) throw response.error;
    return OrderDetailModel.fromJson(response.data!['data']);
  }

  Future<List<Review>> getReviews({
    required int userId,
    required PageFilter pageFilter,
  }) async {
    final response = await service.get(
      // path: 'review/reviews',
      path: 'review/user/$userId/my-reviews',
      params: pageFilter.toJson(),
    );
    if (response.hasError) throw response.error;
    final reviews = List.from(
      response.data!['data'],
    ).map((hist) => Review.fromJson(hist));
    return reviews.toList();
  }

  Future<Review> editProductReview({
    required int reviewId,
    required String comment,
    required double rating,
    required bool isPublic,
  }) async {
    final response = await service.put(
      path: 'review/UpdateReview/$reviewId',
      data: {
        "reviewComment": "string",
        "rating": rating.toInt(),
        "isPublic": true,
      },
    );
    if (response.hasError) throw response.error;
    return Review.fromJson(response.data!['data']);
  }

  Future<String> deleteProductReview({required int reviewId}) async {
    final response = await service.delete(path: 'review/$reviewId');
    if (response.hasError) throw response.error;
    return response.data!['responseMessage'] as String;
  }

  Future<void> addCard(DebitCard card) async {
    final response = await service.post(
      path: 'profile/user/${card.userId}/card',
      data: card.toJson(),
    );
    if (response.hasError) throw response.error;
  }

  Future<void> deleteCard(DebitCard card) async {
    final response = await service.delete(path: 'profile/user/card/${card.id}');
    if (response.hasError) throw response.error;
  }

  Future<List<DebitCard>> getCards(PageFilter pageFilter) async {
    final userId = UserPreference.getUser()!.userId;
    final response = await service.get(
      path: 'profile/user/$userId/cards',
      params: pageFilter.toJson(),
    );
    if (response.hasError) throw response.error;
    final cards = List.from(
      response.data!['data'],
    ).map((hist) => DebitCard.fromJson(Map<String, dynamic>.from(hist)));
    return cards.toList();
  }
}
