import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/core/enum/rating_filter_enum.dart';
import 'package:drugs_ng/features/product/data/models/product_review.dart';
import 'package:drugs_ng/features/product/data/repositories/product_repository.dart';
import 'package:drugs_ng/features/profile/data/repositories/review_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductReviewCubit extends Cubit<ProductReviewState> {
  final ProductRepository repo = ProductRepository();
  final ReviewRepository reviewRepo = ReviewRepository();
  final int productId;
  static const int pageSize = 20;

  ProductReviewCubit(this.productId) : super(ProductReviewState());

  Future<void> addProductReview({
    required int userId,
    required int rating,
    required String message,
    required bool isPublic,
  }) async {
    emit(state.copyWith(status: LoadStatusEnum.loading));
    final result = await reviewRepo.addProductReview(
      userId: 0,
      message: message,
      productId: productId,
      rating: rating,
      isPublic: isPublic,
    );
    result.fold(
      (error) {
        emit(state.copyWith(status: LoadStatusEnum.failed, error: error));
      },
      (review) {
        emit(
          state.copyWith(
            status: LoadStatusEnum.success,
            reviews: [review, ...state.reviews],
          ),
        );
      },
    );
  }

  Future getProductReviews() async {
    emit(state.copyWith(status: LoadStatusEnum.loading));
    final result = await reviewRepo.getProductReview(productId, 0, pageSize);
    result.fold(
      (left) {
        emit(state.copyWith(status: LoadStatusEnum.failed, error: left));
      },
      (right) {
        emit(
          state.copyWith(
            status: LoadStatusEnum.success,
            reviews: right,
            filterReviews: right,
          ),
        );
      },
    );
  }

  Future nextPage() async {
    int pageIndex = state.pageIndex;
    if (state.reviews.isNotEmpty) {
      pageIndex += 1;
    }
    final result = await reviewRepo.getProductReview(
      productId,
      pageIndex,
      pageSize,
    );
    result.fold(
      (left) {
        emit(state.copyWith(status: LoadStatusEnum.loading));
      },
      (right) {
        List<ProductReview> reviews = state.reviews;
        reviews.addAll(right);
        emit(
          state.copyWith(
            pageIndex: pageIndex,
            pageSize: pageSize,
            reviews: right,
            filterReviews: right,
            stars: state.stars,
          ),
        );
      },
    );
  }

  void filter(RatingFilterEnum rating) {
    List<ProductReview> filter =
        state.reviews.where((f) {
          if (rating.valueInt == f.rating || rating == RatingFilterEnum.all) {
            return true;
          } else {
            return false;
          }
        }).toList();
    emit(state.copyWith(filterReviews: filter, stars: rating));
  }
}

class ProductReviewState extends Equatable {
  final RatingFilterEnum stars;
  final int pageIndex;
  final List<ProductReview> reviews;
  final List<ProductReview> filterReviews;
  final ApiError? error;
  final LoadStatusEnum status;

  const ProductReviewState({
    this.stars = RatingFilterEnum.all,
    this.pageIndex = 0,
    this.reviews = const [],
    this.filterReviews = const [],
    this.error,
    this.status = LoadStatusEnum.initial,
  });

  ProductReviewState copyWith({
    RatingFilterEnum? stars,
    int? pageIndex,
    int? pageSize,
    List<ProductReview>? reviews,
    List<ProductReview>? filterReviews,
    ApiError? error,
    LoadStatusEnum? status,
  }) {
    return ProductReviewState(
      stars: stars ?? this.stars,
      pageIndex: pageIndex ?? this.pageIndex,
      reviews: reviews ?? this.reviews,
      filterReviews: filterReviews ?? this.filterReviews,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    pageIndex,
    reviews,
    stars,
    filterReviews,
    status,
    error,
  ];
}
