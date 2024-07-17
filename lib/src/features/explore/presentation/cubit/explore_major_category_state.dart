part of 'explore_major_category_cubit.dart';

enum MajorCategoryType {
  drug,
  healthCare;

  String get displayName {
    switch (this) {
      case drug:
        return "Drugs";
      case healthCare:
        return "Helth Care";
    }
  }
}

sealed class ExploreMajorCategoryState extends Equatable {
  const ExploreMajorCategoryState();

  @override
  List<Object> get props => [];
}

final class ExploreMajorCategoryInitial extends ExploreMajorCategoryState {}

final class ExploreMajorCategoryLoading extends ExploreMajorCategoryState {}

final class ExploreMajorCategorySuccess extends ExploreMajorCategoryState {
  final MajorCategoryData categoryData;
  final MajorCategoryType categoryType;
  const ExploreMajorCategorySuccess(this.categoryData,
      [this.categoryType = MajorCategoryType.drug]);

  List<MajorCategory> get categoryList {
    if (categoryType == MajorCategoryType.drug) {
      return categoryData.drugCategory;
    } else {
      return categoryData.healthCareCategory;
    }
  }

  @override
  List<Object> get props => [categoryData, categoryType];
}

final class ExploreMajorCategoryFailed extends ExploreMajorCategoryState {
  final AppError error;
  const ExploreMajorCategoryFailed(this.error);
  @override
  List<Object> get props => [error];
}
