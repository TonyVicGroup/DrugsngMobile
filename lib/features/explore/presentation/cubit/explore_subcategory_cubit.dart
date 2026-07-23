import 'package:drugs_ng/features/explore/data/repository/explore_repository.dart';
import 'package:drugs_ng/features/explore/domain/models/page_filter.dart';
import 'package:drugs_ng/features/explore/domain/models/sub_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'explore_subcategory_state.dart';

class ExploreSubcategoryCubit extends Cubit<ExploreSubcategoryState> {
  final ExploreRepository repo;
  ExploreSubcategoryCubit(this.repo) : super(const ExploreSubcategoryInitial());

  static const int pageSize = 20;

  Future getSubcategories(int categoryId) async {
    emit(
      ExploreSubcategoryLoading(
        state.subcategories,
        state.searchResult,
        state.pageIndex,
      ),
    );
    final result = await repo.getSubcategories(
      categoryId,
      PageFilter(pageNumber: state.pageIndex, pageSize: pageSize),
    );
    result.fold(
      (left) {
        emit(
          ExploreSubcategoryFailed(
            state.subcategories,
            state.searchResult,
            state.pageIndex,
            left.message,
          ),
        );
      },
      (right) {
        emit(ExploreSubcategorySuccess(right, right, state.pageIndex));
      },
    );
  }

  Future nextPage(int categoryId) async {
    int nextPage = state.pageIndex;
    if (state.subcategories.isNotEmpty) {
      // go to the next page only if the list is not empty
      // else just reload the current page
      nextPage += 1;
    }
    final result = await repo.getSubcategories(
      categoryId,
      PageFilter(pageNumber: nextPage, pageSize: pageSize),
    );
    result.fold(
      (left) {
        emit(
          ExploreSubcategoryFailed(
            state.subcategories,
            state.searchResult,
            state.pageIndex,
            left.message,
          ),
        );
      },
      (right) {
        emit(
          ExploreSubcategorySuccess(
            state.subcategories..addAll(right),
            state.searchResult..addAll(right),
            nextPage,
          ),
        );
      },
    );
  }

  void search(String query) {
    emit(
      ExploreSubcategorySuccess(
        state.subcategories,
        state.subcategories
            .where((subCat) => subCat.name.contains(query))
            .toList(),
        state.pageIndex,
      ),
    );
  }
}
