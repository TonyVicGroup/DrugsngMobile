import 'package:drugs_ng/src/features/explore/data/repository/explore_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'explore_subcategory_state.dart';

class ExploreSubcategoryCubit extends Cubit<ExploreSubcategoryState> {
  final ExploreRepository repo;
  ExploreSubcategoryCubit(this.repo) : super(const ExploreSubcategoryInitial());

  Future getSubcategories(String category) async {
    emit(ExploreSubcategoryLoading(state.subcategories, state.searchResult));
    final result = await repo.getSubcategories(category);
    result.fold((left) {
      emit(ExploreSubcategoryFailed(
          state.subcategories, state.searchResult, "Failed"));
    }, (right) {
      emit(ExploreSubcategorySuccess(right, right));
    });
  }

  void search(String query) {
    emit(
      ExploreSubcategorySuccess(
        state.subcategories,
        state.subcategories
            .where(
              (subCat) => subCat.contains(query),
            )
            .toList(),
      ),
    );
  }
}
