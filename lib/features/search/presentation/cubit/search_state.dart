part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState(this.searchResult);
  final List<SearchItem> searchResult;

  @override
  List<Object> get props => [searchResult];
}

class SearchInitial extends SearchState {
  SearchInitial() : super([]);
}

class SearchLoading extends SearchState {
  const SearchLoading(super.searchResult);
}

class SearchSuccess extends SearchState {
  const SearchSuccess(super.searchResult);
}

class SearchError extends SearchState {
  final AppError error;
  const SearchError(this.error, super.searchResult);

  @override
  List<Object> get props => [error, searchResult];
}
