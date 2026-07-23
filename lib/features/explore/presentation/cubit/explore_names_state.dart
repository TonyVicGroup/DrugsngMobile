part of 'explore_names_cubit.dart';

sealed class ExploreNamesState extends Equatable {
  final List<GenericBrandName> brands;
  final List<GenericBrandName> searchResult;
  final int pageNumber;
  const ExploreNamesState(this.brands, this.searchResult, this.pageNumber);

  @override
  List<Object> get props => [brands, searchResult];
}

final class ExploreNamesInitial extends ExploreNamesState {
  const ExploreNamesInitial() : super(const [], const [], 0);
}

final class ExploreNamesLoading extends ExploreNamesState {
  const ExploreNamesLoading(super.brands, super.searchResult, super.pageNumber);
}

final class ExploreNamesSuccess extends ExploreNamesState {
  const ExploreNamesSuccess(super.brands, super.searchResult, super.pageNumber);
}

final class ExploreNamesFailed extends ExploreNamesState {
  final String message;
  const ExploreNamesFailed(
      super.brands, super.searchResult, super.pageNumber, this.message);
  @override
  List<Object> get props => [message, searchResult, brands];
}
