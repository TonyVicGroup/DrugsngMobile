part of 'explore_subcategory_cubit.dart';

sealed class ExploreSubcategoryState extends Equatable {
  final List<SubCategory> subcategories;
  final List<SubCategory> searchResult;
  final int pageIndex;
  const ExploreSubcategoryState(
      this.subcategories, this.searchResult, this.pageIndex);

  @override
  List<Object> get props => [subcategories, searchResult, pageIndex];
}

final class ExploreSubcategoryInitial extends ExploreSubcategoryState {
  const ExploreSubcategoryInitial() : super(const [], const [], 0);
}

final class ExploreSubcategoryLoading extends ExploreSubcategoryState {
  const ExploreSubcategoryLoading(
      super.subcategories, super.searchResult, super.pageIndex);
}

final class ExploreSubcategorySuccess extends ExploreSubcategoryState {
  const ExploreSubcategorySuccess(
      super.subcategories, super.searchResult, super.pageIndex);
}

final class ExploreSubcategoryFailed extends ExploreSubcategoryState {
  final String message;
  const ExploreSubcategoryFailed(
      super.subcategories, super.searchResult, super.pageIndex, this.message);
  @override
  List<Object> get props => [message, subcategories, pageIndex, searchResult];
}
