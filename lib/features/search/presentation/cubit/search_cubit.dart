import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/search/data/models/search_item.dart';
import 'package:drugs_ng/features/search/data/repositories/search_repository.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository repo = SearchRepository();
  SearchCubit() : super(SearchState());

  Future search(String query, SearchType type) async {
    emit(state.copyWith(status: LoadStatusEnum.loading));

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
        emit(
          state.copyWith(status: LoadStatusEnum.failed, error: left.message),
        );
      },
      (right) {
        emit(
          state.copyWith(searchResult: right, status: LoadStatusEnum.success),
        );
      },
    );
  }
}

class SearchState extends Equatable {
  const SearchState({
    this.searchResult = const [],
    this.status = LoadStatusEnum.initial,
    this.error,
  });
  final List<SearchItem> searchResult;
  final LoadStatusEnum status;
  final String? error;

  SearchState copyWith({
    List<SearchItem>? searchResult,
    LoadStatusEnum? status,
    String? error,
  }) {
    return SearchState(
      searchResult: searchResult ?? this.searchResult,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [searchResult, status, error];
}
