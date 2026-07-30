import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/explore/data/repository/explore_repository.dart';
import 'package:drugs_ng/features/explore/domain/models/major_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class ExploreMajorCategoryCubit extends Cubit<ExploreMajorCategoryState> {
  final ExploreRepository repo = ExploreRepository();

  ExploreMajorCategoryCubit() : super(const ExploreMajorCategoryState());

  Future getCategories() async {
    emit(state.copyWith(status: LoadStatusEnum.loading));
    final result = await repo.getMajorCategories();
    result.fold(
      (left) {
        emit(
          state.copyWith(error: left.message, status: LoadStatusEnum.failed),
        );
      },
      (right) {
        emit(
          state.copyWith(categoryData: right, status: LoadStatusEnum.success),
        );
      },
    );
  }

  void changeCategoryType(MajorCategoryType type) {
    emit(state.copyWith(categoryType: type));
  }
}

class ExploreMajorCategoryState extends Equatable {
  final MajorCategoryData? categoryData;
  final MajorCategoryType? categoryType;
  final LoadStatusEnum status;
  final String? error;

  const ExploreMajorCategoryState({
    this.categoryData,
    this.categoryType,
    this.status = LoadStatusEnum.initial,
    this.error,
  });

  bool get isEmpty => categoryData?.isEmpty ?? false;

  List<MajorCategory> get categoryList {
    if (categoryType == MajorCategoryType.drug) {
      return categoryData?.drugCategory ?? [];
    } else {
      return categoryData?.healthCareCategory ?? [];
    }
  }

  ExploreMajorCategoryState copyWith({
    MajorCategoryData? categoryData,
    MajorCategoryType? categoryType,
    LoadStatusEnum? status,
    String? error,
  }) {
    return ExploreMajorCategoryState(
      categoryData: categoryData ?? this.categoryData,
      categoryType: categoryType ?? this.categoryType,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [categoryData, categoryType, status, error];
}

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
