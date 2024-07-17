part of 'explore_filter_bloc.dart';

class ExploreFilterState extends Equatable {
  final List<ProductDetail> products;
  final RatingEnum ratingEnum;
  final Set<String> brandName;
  final String? subcategory;
  final int minPriceRange;
  final int maxPriceRange;

  const ExploreFilterState({
    required this.products,
    required this.ratingEnum,
    required this.brandName,
    required this.subcategory,
    required this.minPriceRange,
    required this.maxPriceRange,
  });

  factory ExploreFilterState.initial() {
    return const ExploreFilterState(
      products: [],
      ratingEnum: RatingEnum.all,
      brandName: {},
      subcategory: null,
      minPriceRange: 0,
      maxPriceRange: 100,
    );
  }

  ExploreFilterState copy({
    List<ProductDetail>? products,
    RatingEnum? ratingEnum,
    Set<String>? brandName,
    String? subcategory,
    int? minPriceRange,
    int? maxPriceRange,
  }) =>
      ExploreFilterState(
        products: products ?? this.products,
        ratingEnum: ratingEnum ?? this.ratingEnum,
        brandName: brandName ?? this.brandName,
        subcategory: subcategory ?? this.subcategory,
        minPriceRange: minPriceRange ?? this.minPriceRange,
        maxPriceRange: maxPriceRange ?? this.maxPriceRange,
      );

  @override
  List<Object> get props =>
      [products, ratingEnum, brandName, subcategory ?? ""];

  List<String> get tags {
    return [
      ratingEnum.displayName,
      if (subcategory != null) subcategory!,
      ...brandName,
    ];
  }
}
