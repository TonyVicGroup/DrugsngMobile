import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:drugs_ng/features/product/data/models/product_review.dart';
import 'package:drugs_ng/features/profile/data/datasources/review_datasource.dart';
import 'package:drugs_ng/features/profile/data/models/review.dart';
import 'package:either_dart/either.dart';

class ReviewRepository {
  final ReviewDatasource datasource = ReviewDatasource();

  AsyncApiErrorOr<List<Review>> getReviews({
    required int userId,
    required PageFilter pageFilter,
  }) async {
    try {
      final response = await datasource.getReviews(
        userId: userId,
        pageFilter: pageFilter,
      );
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<Review> editProductReview({
    required int reviewId,
    required String comment,
    required double rating,
    required bool isPublic,
  }) async {
    try {
      final response = await datasource.editProductReview(
        reviewId: reviewId,
        comment: comment,
        rating: rating,
        isPublic: isPublic,
      );
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<String> deleteProductReview({required int reviewId}) async {
    try {
      final response = await datasource.deleteProductReview(reviewId: reviewId);
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<ProductReview> addProductReview({
    required int userId,
    required String message,
    required int productId,
    required int rating,
    required bool isPublic,
  }) async {
    try {
      final response = await datasource.addProductReview(
        userId: userId,
        message: message,
        productId: productId,
        rating: rating,
        isPublic: isPublic,
      );
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<ProductReview>> getProductReview(
    int productId,
    int pageNumber,
    int pageSize,
  ) async {
    try {
      final response = await datasource.getProductReview(
        productId,
        pageNumber,
        pageSize,
      );
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
