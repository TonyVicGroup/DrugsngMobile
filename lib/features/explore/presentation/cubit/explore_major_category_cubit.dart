import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/features/explore/data/repository/explore_repository.dart';
import 'package:drugs_ng/features/explore/domain/models/major_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'explore_major_category_state.dart';

class ExploreMajorCategoryCubit extends Cubit<ExploreMajorCategoryState> {
  final ExploreRepository repo = ExploreRepository();

  ExploreMajorCategoryCubit() : super(const ExploreMajorCategoryInitial());

  Future getCategories() async {
    emit(ExploreMajorCategoryLoading(state.categoryData, state.categoryType));
    final result = await repo.getMajorCategories();
    result.fold(
      (left) {
        emit(
          ExploreMajorCategoryFailed(
            state.categoryData,
            state.categoryType,
            left,
          ),
        );
      },
      (right) {
        emit(ExploreMajorCategorySuccess(right, state.categoryType));
      },
    );
  }

  void changeCategoryType(MajorCategoryType type) {
    if (state is ExploreMajorCategorySuccess) {
      final successState = state as ExploreMajorCategorySuccess;
      emit(ExploreMajorCategorySuccess(successState.categoryData, type));
    }
  }
}
