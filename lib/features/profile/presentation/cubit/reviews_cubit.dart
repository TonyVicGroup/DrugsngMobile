import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/core/enum/rating_filter_enum.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
// import 'package:drugs_ng/src/features/product/domain/models/review.dart';
import 'package:drugs_ng/features/profile/data/models/review.dart';
import 'package:drugs_ng/features/profile/data/repositories/review_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ReviewRepository repo = ReviewRepository();

  static const int pageSize = 20;

  ReviewsCubit() : super(const ReviewsState());

  Future<void> getReviews(int userId) async {
    emit(state.copyWith(status: LoadStatusEnum.loading));
    final result = await repo.getReviews(
      userId: userId,
      pageFilter: PageFilter(pageNumber: state.page, pageSize: pageSize),
    );
    result.fold(
      (l) {
        emit(state.copyWith(status: LoadStatusEnum.failed, page: state.page));
      },
      (reviews) {
        emit(
          state.copyWith(
            status: LoadStatusEnum.success,
            page: state.page,
            reviews: reviews,
            filter: RatingFilterEnum.all,
          ),
        );
      },
    );
  }

  Future<void> deleteReview({required int reviewId}) async {
    emit(state.copyWith(status: LoadStatusEnum.loading));
    final result = await repo.deleteProductReview(reviewId: reviewId);
    result.fold(
      (l) {
        emit(state.copyWith(status: LoadStatusEnum.failed));
      },
      (message) {
        final updatedReviews =
            state.reviews.where((review) => review.id != reviewId).toList();
        emit(
          state.copyWith(
            status: LoadStatusEnum.success,
            reviews: updatedReviews,
          ),
        );
      },
    );
  }

  Future<void> editReviews({
    required int reviewId,
    required String comment,
    required int rating,
  }) async {
    emit(state.copyWith(addEditStatus: LoadStatusEnum.loading));
    final result = await repo.editProductReview(
      reviewId: reviewId,
      comment: comment,
      rating: rating.toDouble(),
      isPublic: true,
    );
    result.fold(
      (l) {
        emit(state.copyWith(addEditStatus: LoadStatusEnum.failed));
      },
      (updatedReview) {
        final updatedReviews =
            state.reviews.map((review) {
              if (review.id == reviewId) {
                return updatedReview;
              }
              return review;
            }).toList();
        emit(
          state.copyWith(
            addEditStatus: LoadStatusEnum.success,
            reviews: updatedReviews,
          ),
        );
      },
    );
  }

  void filter(RatingFilterEnum filter) {
    emit(state.copyWith(filter: filter));
  }

  void resetData() {
    emit(ReviewsState());
  }
}

class ReviewsState extends Equatable {
  final List<Review> reviews;
  final LoadStatusEnum status;
  final LoadStatusEnum addEditStatus;
  final ApiError? error;
  final int page;
  final RatingFilterEnum filter;

  const ReviewsState({
    this.reviews = const [],
    this.status = LoadStatusEnum.initial,
    this.addEditStatus = LoadStatusEnum.initial,
    this.error,
    this.page = 1,
    this.filter = RatingFilterEnum.all,
  });

  List<Review> get filteredReviews {
    if (filter == RatingFilterEnum.all) {
      return reviews;
    } else {
      return reviews
          .where((review) => review.ratingStar.round() == filter.valueInt)
          .toList();
    }
  }

  ReviewsState copyWith({
    List<Review>? reviews,
    LoadStatusEnum? status,
    LoadStatusEnum? addEditStatus,
    ApiError? error,
    int? page,
    RatingFilterEnum? filter,
  }) {
    return ReviewsState(
      reviews: reviews ?? this.reviews,
      status: status ?? this.status,
      error: error ?? this.error,
      page: page ?? this.page,
      addEditStatus: addEditStatus ?? this.addEditStatus,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [
    reviews,
    status,
    error,
    page,
    filter,
    addEditStatus,
  ];
}
