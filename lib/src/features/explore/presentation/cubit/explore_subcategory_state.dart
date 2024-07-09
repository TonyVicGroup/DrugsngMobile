part of 'explore_subcategory_cubit.dart';

sealed class ExploreSubcategoryState extends Equatable {
  final List<String> subcategories;
  final List<String> searchResult;
  const ExploreSubcategoryState(this.subcategories, this.searchResult);

  @override
  List<Object> get props => [subcategories, searchResult];
}

final class ExploreSubcategoryInitial extends ExploreSubcategoryState {
  const ExploreSubcategoryInitial() : super(const [], const []);
}

final class ExploreSubcategoryLoading extends ExploreSubcategoryState {
  const ExploreSubcategoryLoading(super.subcategories, super.searchResult);
}

final class ExploreSubcategorySuccess extends ExploreSubcategoryState {
  const ExploreSubcategorySuccess(super.subcategories, super.searchResult);
}

final class ExploreSubcategoryFailed extends ExploreSubcategoryState {
  final String message;
  const ExploreSubcategoryFailed(
      super.subcategories, super.searchResult, this.message);
  @override
  List<Object> get props => [message, subcategories, searchResult];
}
