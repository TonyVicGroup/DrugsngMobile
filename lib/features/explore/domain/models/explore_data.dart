import 'package:drugs_ng/core/enum/sort_type_enum.dart';
import 'package:drugs_ng/features/explore/domain/models/explore_filter.dart';
import 'package:drugs_ng/features/explore/presentation/cubit/explore_major_category_cubit.dart';
import 'package:drugs_ng/features/product/domain/models/product_detail.dart';
import 'package:equatable/equatable.dart';

enum ExploreDisplay {
  grid,
  list;

  bool get isGrid => this == grid;
  bool get isList => this == list;
}

class ExploreData extends Equatable {
  final List<ProductDetail> drugProducts;
  final List<ProductDetail> healthCareProducts;
  final MajorCategoryType categoryType;
  final ExploreFilter filter;
  final ExploreDisplay displayType;
  final SortTypeEnum sortType;

  /// get a list of products for the current category
  List<ProductDetail> get products =>
      categoryType.isDrug ? drugProducts : healthCareProducts;

  const ExploreData({
    required this.drugProducts,
    required this.healthCareProducts,
    required this.categoryType,
    required this.filter,
    required this.displayType,
    required this.sortType,
  });

  factory ExploreData.initial() => ExploreData(
    drugProducts: const [],
    healthCareProducts: const [],
    categoryType: MajorCategoryType.drug,
    filter: ExploreFilter.initial(),
    displayType: ExploreDisplay.grid,
    sortType: SortTypeEnum.newArrival,
  );

  ExploreData copy({
    List<ProductDetail>? drugProducts,
    List<ProductDetail>? healthCareProducts,
    MajorCategoryType? categoryType,
    ExploreFilter? filter,
    ExploreDisplay? displayType,
    SortTypeEnum? sortType,
  }) => ExploreData(
    drugProducts: drugProducts ?? this.drugProducts,
    healthCareProducts: healthCareProducts ?? this.healthCareProducts,
    categoryType: categoryType ?? this.categoryType,
    filter: filter ?? this.filter,
    displayType: displayType ?? this.displayType,
    sortType: sortType ?? this.sortType,
  );

  @override
  List<Object?> get props => [
    drugProducts,
    healthCareProducts,
    categoryType,
    filter,
    displayType,
    sortType,
  ];
}
