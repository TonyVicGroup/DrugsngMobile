import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:drugs_ng/features/profile/data/datasources/profile_datasource.dart';
import 'package:drugs_ng/features/profile/data/models/debit_card.dart';
import 'package:drugs_ng/features/profile/data/models/order_detail_model.dart';
import 'package:drugs_ng/features/profile/data/models/order_history.dart';
import 'package:drugs_ng/features/profile/data/models/review.dart';
import 'package:either_dart/either.dart';

class ProfileRepository {
  ProfileDatasource datasource = ProfileDatasource();

  AsyncApiErrorOr<List<OrderHistory>> getOrderHistory({
    required String userId,
    required PageFilter pageFilter,
    required String status,
  }) async {
    try {
      final history = await datasource.getOrderHistory(
        userId: userId,
        pageFilter: pageFilter,
        status: status,
      );
      return Right(history);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<OrderDetailModel> getOrderDetails(int orderId) async {
    try {
      final details = await datasource.getOrderDetails(orderId);
      return Right(details);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<Review>> getReviews({
    required int userId,
    required PageFilter pageFilter,
  }) async {
    try {
      final reviews = await datasource.getReviews(
        userId: userId,
        pageFilter: pageFilter,
      );
      return Right(reviews);
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

  AsyncApiErrorOr<void> addCard(DebitCard card) async {
    try {
      final response = await datasource.addCard(card);
      return Right(response);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<void> deleteCard(DebitCard card) async {
    try {
      final data = await datasource.deleteCard(card);
      return Right(data);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<List<DebitCard>> getCards(PageFilter pageFilter) async {
    try {
      final response = await datasource.getCards(pageFilter);
      return Right(response);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
