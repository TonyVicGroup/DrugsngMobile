import 'dart:async';

import 'package:drugs_ng/src/core/data/models/product_detail.dart';
import 'package:drugs_ng/src/core/enum/rating_enum.dart';
import 'package:drugs_ng/src/features/explore/presentation/bloc/explore_bloc/explore_bloc.dart';
import 'package:drugs_ng/src/features/explore/presentation/cubit/explore_major_category_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'explore_filter_event.dart';
part 'explore_filter_state.dart';

class ExploreFilterBloc extends Bloc<ExploreFilterEvent, ExploreFilterState> {
  // final List<Product> product;
  final ExploreBloc _exploreBloc;
  // ignore: unused_field
  late StreamSubscription _todoSubscript;

  ExploreFilterBloc({required ExploreBloc exploreBloc})
      : _exploreBloc = exploreBloc,
        super(ExploreFilterState.initial()) {
    on<UpdateExploreFilter>(_onUpdateExploreFilter);
    on<ResetExploreFilter>(_onResetExploreFilter);
    on<ChangeSubcategoryFilter>(_onChangeSubcategoryFilter);
    on<ChangeRatingFilter>(_onChangeRatingFilter);
    on<BrandNameFilter>(_onBrandNameFilter);

    _todoSubscript = _exploreBloc.stream.listen((event) {
      add(UpdateExploreFilter(
        brandNames: state.brandName,
        subcategory: state.subcategory,
        rating: state.ratingEnum,
        minPriceRange: state.minPriceRange,
        maxPriceRange: state.maxPriceRange,
      ));
    });
  }

  void _onUpdateExploreFilter(
      UpdateExploreFilter event, Emitter<ExploreFilterState> emit) {
    final exploreState = _exploreBloc.state;
    List<ProductDetail> prod =
        exploreState.categoryType == MajorCategoryType.drug
            ? exploreState.drugProducts
            : exploreState.healthCareProducts;
    Iterable<ProductDetail> products = prod.where((prod) {
      bool filterProd = true;
      // rating
      // if (event.rating != RatingEnum.all) {
      //   filterProd = prod.rating.round() == event.rating.starCount;
      // }
      // brandName
      if (event.brandNames.isNotEmpty &&
          event.brandNames.contains(prod.brandName)) {
        filterProd = false;
      }
      // subcategory
      // if (event.subcategory == prod.category) {
      //   filterProd = filterProd && true;
      // }
      return filterProd;
    });
    emit(
      ExploreFilterState(
        products: products.toList(),
        ratingEnum: event.rating,
        brandName: event.brandNames.toSet(),
        subcategory: event.subcategory,
        minPriceRange: event.minPriceRange,
        maxPriceRange: event.maxPriceRange,
      ),
    );
  }

  void _onResetExploreFilter(
      ResetExploreFilter event, Emitter<ExploreFilterState> emit) {
    final exploreState = _exploreBloc.state;
    if (exploreState is ExploreSuccess) {
      emit(ExploreFilterState(
        products: exploreState.categoryType == MajorCategoryType.drug
            ? exploreState.drugProducts
            : exploreState.healthCareProducts,
        ratingEnum: RatingEnum.all,
        brandName: const {},
        subcategory: null,
        minPriceRange: 0,
        maxPriceRange: 100,
      ));
    }
  }

  void _onBrandNameFilter(
      BrandNameFilter event, Emitter<ExploreFilterState> emit) {}
  void _onChangeRatingFilter(
      ChangeRatingFilter event, Emitter<ExploreFilterState> emit) {}
  void _onChangeSubcategoryFilter(
      ChangeSubcategoryFilter event, Emitter<ExploreFilterState> emit) {}
}
