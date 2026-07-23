import 'package:drugs_ng/features/explore/domain/models/generic_brand_name.dart';
import 'package:drugs_ng/features/explore/domain/models/major_category.dart';
import 'package:drugs_ng/features/explore/domain/models/sub_category.dart';
import 'package:equatable/equatable.dart';

class ExploreFilter extends Equatable {
  static const String _searchTermKey = "SearchTerm";
  static const String _categoryIdKey = "CategoryId";
  static const String _subCategoryIdKey = "SubCategoryId";
  static const String _brandIdsKey = "BrandIds";
  static const String _genericIdsKey = "GenericIds";
  static const String _starsKey = "Stars";
  static const String _pageSizeKey = "PageSize";
  static const String _maxPriceKey = "MaxPrice";
  static const String _minPriceKey = "MinPrice";
  static const String _pageNumberKey = "PageNumber";

  final String? searchTerm;
  final MajorCategory category;
  final List<SubCategory> subCategory;
  final List<GenericBrandName> genericNames;
  final List<GenericBrandName> brandNames;
  final int? stars;
  final int? pageSize;
  final int? maxPrice;
  final int? minPrice;
  final int page;

  /// get a list of current filter tags
  List<String> get filterTags {
    return [
      if (stars != null && stars! > 0) "$stars Stars",
      if (subCategory.isNotEmpty) subCategory.map((e) => e.name).join(', '),
      if (brandNames.isNotEmpty) brandNames.map((e) => e.name).join(', '),
      if (genericNames.isNotEmpty) genericNames.map((e) => e.name).join(', '),
    ];
  }

  const ExploreFilter({
    required this.searchTerm,
    required this.category,
    required this.subCategory,
    required this.genericNames,
    required this.brandNames,
    required this.stars,
    required this.pageSize,
    required this.maxPrice,
    required this.minPrice,
    required this.page,
  });

  factory ExploreFilter.initial() => ExploreFilter(
    searchTerm: null,
    category: MajorCategory.empty(),
    subCategory: const [],
    genericNames: const [],
    brandNames: const [],
    stars: null,
    pageSize: null,
    maxPrice: null,
    minPrice: null,
    page: 0,
  );

  ExploreFilter copy({
    String? searchTerm,
    MajorCategory? category,
    List<SubCategory>? subCategory,
    List<GenericBrandName>? genericNames,
    List<GenericBrandName>? brandNames,
    int? stars,
    int? pageSize,
    int? maxPrice,
    int? minPrice,
    int? page,
  }) => ExploreFilter(
    searchTerm: searchTerm ?? this.searchTerm,
    category: category ?? this.category,
    subCategory: subCategory ?? this.subCategory,
    genericNames: genericNames ?? this.genericNames,
    brandNames: brandNames ?? this.brandNames,
    stars: stars == -1 ? null : stars ?? this.stars,
    pageSize: pageSize ?? this.pageSize,
    maxPrice: maxPrice ?? this.maxPrice,
    minPrice: minPrice ?? this.minPrice,
    page: page ?? this.page,
  );

  Map<String, dynamic> toJson() => {
    if (searchTerm != null) _searchTermKey: searchTerm,
    _categoryIdKey: category.id,
    if (subCategory.isNotEmpty)
      _subCategoryIdKey: subCategory.map((sC) => sC.id).toList(),
    if (brandNames.isNotEmpty)
      _brandIdsKey: brandNames.map((br) => br.id).toList(),
    if (genericNames.isNotEmpty)
      _genericIdsKey: genericNames.map((gen) => gen.id).toList(),
    if (stars != null) _starsKey: stars,
    if (pageSize != null) _pageSizeKey: pageSize,
    if (maxPrice != null) _maxPriceKey: maxPrice,
    if (minPrice != null) _minPriceKey: minPrice,
    _pageNumberKey: page,
  };

  @override
  List<Object?> get props => [
    searchTerm,
    category,
    subCategory,
    brandNames,
    genericNames,
    stars,
    pageSize,
    maxPrice,
    minPrice,
    page,
  ];
}
