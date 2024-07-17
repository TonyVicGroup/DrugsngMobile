part of 'explore_bloc.dart';

abstract class ExploreState extends Equatable {
  final List<ProductDetail> drugProducts;
  final List<ProductDetail> healthCareProducts;
  final MajorCategoryType categoryType;
  final bool isGrid;
  final SortTypeEnum sortType;
  const ExploreState(
    this.drugProducts,
    this.healthCareProducts,
    this.categoryType,
    this.isGrid,
    this.sortType,
  );

  @override
  List<Object> get props =>
      [drugProducts, healthCareProducts, categoryType, isGrid, sortType];
}

class ExploreInitial extends ExploreState {
  ExploreInitial()
      : super([], [], MajorCategoryType.drug, true, SortTypeEnum.newArrival);
}

class ExploreSuccess extends ExploreState {
  const ExploreSuccess({
    required List<ProductDetail> drugProducts,
    required List<ProductDetail> healthCareProducts,
    required MajorCategoryType categoryType,
    required bool isGrid,
    required SortTypeEnum sortType,
  }) : super(
          drugProducts,
          healthCareProducts,
          categoryType,
          isGrid,
          sortType,
        );

  ExploreSuccess copy(
          {List<ProductDetail>? drugProducts,
          List<ProductDetail>? healthCareProducts,
          MajorCategoryType? categoryType,
          bool? isGrid,
          SortTypeEnum? sortType}) =>
      ExploreSuccess(
        drugProducts: drugProducts ?? this.drugProducts,
        healthCareProducts: healthCareProducts ?? this.healthCareProducts,
        categoryType: categoryType ?? this.categoryType,
        isGrid: isGrid ?? this.isGrid,
        sortType: sortType ?? this.sortType,
      );

  @override
  List<Object> get props =>
      [drugProducts, healthCareProducts, categoryType, isGrid, sortType];
}

class ExploreLoading extends ExploreState {
  const ExploreLoading(super.drugProducts, super.healthCareProducts,
      super.categoryType, super.isGrid, super.sortType);
}

class ExploreFailed extends ExploreState {
  final AppError error;

  const ExploreFailed(super.drugProducts, super.healthCareProducts,
      super.categoryType, super.isGrid, super.sortType, this.error);

  @override
  List<Object> get props => [
        drugProducts,
        healthCareProducts,
        categoryType,
        error,
        isGrid,
        sortType,
      ];
}
