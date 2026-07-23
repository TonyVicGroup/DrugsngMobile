import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:drugs_ng/features/product/data/models/product_review.dart';
import 'package:drugs_ng/features/profile/data/models/review.dart';

class ReviewDatasource {
  final RestService service = RestService(baseUrl: AppUtils.baseUrl);

  Future<List<Review>> getReviews({
    required int userId,
    required PageFilter pageFilter,
  }) async {
    final response = await service.get(
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

  Future<ProductReview> addProductReview({
    required int userId,
    required String message,
    required int productId,
    required int rating,
    required bool isPublic,
  }) async {
    final response = await service.post(
      path: 'review/CreateReview',
      data: {
        "productId": productId,
        "reviewComment": message,
        "isPublic": isPublic,
        "rating": rating,
      },
    );
    if (response.hasError) throw response.error;
    return ProductReview.fromJson(response.data!['data']);
  }

  Future<List<ProductReview>> getProductReview(
    int productId,
    int pageNumber,
    int pageSize,
  ) async {
    final response = await service.get(
      path: 'review/product/$productId/reviews',
      params: {"PageNumber": pageNumber, "PageSize": pageSize},
    );
    if (response.hasError) throw response.error;
    final reviews =
        List<Map>.from(
          response.data!['data'],
        ).map((e) => ProductReview.fromJson(e)).toList();
    return reviews;
  }
}
