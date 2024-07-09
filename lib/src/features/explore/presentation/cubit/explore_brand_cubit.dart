import 'package:drugs_ng/src/features/explore/data/repository/explore_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'explore_brand_state.dart';

class ExploreBrandCubit extends Cubit<ExploreBrandState> {
  final ExploreRepository repo;
  ExploreBrandCubit(this.repo) : super(const ExploreBrandInitial());

  Future getSubcategories(String category) async {
    emit(ExploreBrandLoading(state.brands, state.searchResult));
    final result = await repo.getSubcategories(category);
    result.fold((left) {
      emit(ExploreBrandFailed(state.brands, state.searchResult, "Failed"));
    }, (right) {
      emit(ExploreBrandSuccess(right, right));
    });
  }

  void search(String query) {
    emit(
      ExploreBrandSuccess(
        state.brands,
        state.brands
            .where(
              (subCat) => subCat.contains(query),
            )
            .toList(),
      ),
    );
  }
}
