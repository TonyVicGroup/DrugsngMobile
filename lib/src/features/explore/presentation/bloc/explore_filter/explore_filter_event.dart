part of 'explore_filter_bloc.dart';

sealed class ExploreFilterEvent extends Equatable {
  const ExploreFilterEvent();

  @override
  List<Object> get props => [];
}

final class UpdateExploreFilter extends ExploreFilterEvent {
  final Iterable<String> brandNames;
  final String? subcategory;
  final RatingEnum rating;
  final int minPriceRange;
  final int maxPriceRange;

  const UpdateExploreFilter({
    required this.brandNames,
    required this.subcategory,
    required this.rating,
    required this.minPriceRange,
    required this.maxPriceRange,
  });

  @override
  List<Object> get props => [brandNames, subcategory ?? "", rating];
}

final class ResetExploreFilter extends ExploreFilterEvent {}

final class BrandNameFilter extends ExploreFilterEvent {
  final Iterable<String> brandNames;

  const BrandNameFilter(this.brandNames);

  @override
  List<Object> get props => brandNames.toList();
}

final class ChangeRatingFilter extends ExploreFilterEvent {
  final RatingEnum rating;

  const ChangeRatingFilter(this.rating);

  @override
  List<Object> get props => [rating];
}

final class ChangeSubcategoryFilter extends ExploreFilterEvent {
  final String subcategory;

  const ChangeSubcategoryFilter(this.subcategory);

  @override
  List<Object> get props => [subcategory];
}
