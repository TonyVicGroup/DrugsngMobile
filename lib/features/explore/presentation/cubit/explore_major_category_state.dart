part of 'explore_major_category_cubit.dart';

enum MajorCategoryType {
  drug,
  healthCare;

  bool get isDrug => this == drug;
  bool get isHealthCare => this == healthCare;

  String get displayName {
    switch (this) {
      case drug:
        return "Drugs";
      case healthCare:
        return "Health Care";
    }
  }
}

sealed class ExploreMajorCategoryState extends Equatable {
  final MajorCategoryData categoryData;
  final MajorCategoryType categoryType;
  const ExploreMajorCategoryState(this.categoryData, this.categoryType);

  bool get isEmpty => categoryData.isEmpty;

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

final class ExploreMajorCategoryInitial extends ExploreMajorCategoryState {
  const ExploreMajorCategoryInitial(
      {MajorCategoryData categoryData =
          const MajorCategoryData(drugCategory: [], healthCareCategory: []),
      MajorCategoryType categoryType = MajorCategoryType.drug})
      : super(categoryData, categoryType);
}

final class ExploreMajorCategoryLoading extends ExploreMajorCategoryState {
  const ExploreMajorCategoryLoading(super.categoryData, super.categoryType);
}

final class ExploreMajorCategorySuccess extends ExploreMajorCategoryState {
  const ExploreMajorCategorySuccess(super.categoryData, super.categoryType);
}

final class ExploreMajorCategoryFailed extends ExploreMajorCategoryState {
  final AppError error;
  const ExploreMajorCategoryFailed(
    super.categoryData,
    super.categoryType,
    this.error,
  );
  @override
  List<Object> get props => [categoryData, categoryType, error];
}
