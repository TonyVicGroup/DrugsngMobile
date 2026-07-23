import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/features/search/data/models/search_item.dart';
import 'package:drugs_ng/features/search/domain/repositories/search_repo.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo repo;
  SearchCubit(this.repo) : super(SearchInitial());

  Future search(String query, SearchType type) async {
    emit(SearchLoading(state.searchResult));

    final Either<ApiError, List<SearchItem>> result;
    switch (type) {
      case SearchType.all:
        result = await repo.all(query);
        break;
      case SearchType.product:
        result = await repo.product(query);
        break;
      case SearchType.diagnosticTest:
        result = await repo.diagnosticTest(query);
        break;
      case SearchType.wellnessPackage:
        result = await repo.wellnessPackage(query);
        break;
      case SearchType.testAndPackage:
        result = await repo.testAndPackage(query);
        break;
    }
    result.fold(
      (left) {
        emit(SearchError(left, state.searchResult));
      },
      (right) {
        emit(SearchSuccess(result.right));
      },
    );
  }
}
