import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/sort_type_enum.dart';
import 'package:drugs_ng/features/explore/data/repository/explore_repository.dart';
import 'package:drugs_ng/features/explore/domain/models/explore_data.dart';
import 'package:drugs_ng/features/explore/domain/models/explore_filter.dart';
import 'package:drugs_ng/features/explore/presentation/cubit/explore_major_category_cubit.dart';
import 'package:drugs_ng/features/product/domain/models/product_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ExploreRepository repo = ExploreRepository();

  ExploreCubit() : super(ExploreInitial());

  void toggle() async {
    ExploreDisplay display =
        state.data.displayType.isGrid
            ? ExploreDisplay.list
            : ExploreDisplay.grid;
    emit(ExploreSuccess(state.data.copy(displayType: display)));
  }

  void sort(SortTypeEnum sortType) async {
    emit(ExploreSuccess(state.data.copy(sortType: sortType)));
  }

  Future<void> updateFilter(ExploreFilter filter) async {
    emit(ExploreSuccess(state.data.copy(filter: filter)));
    await refreshCategory(state.data.categoryType, true);
  }

  Future<void> refreshCategory(
    MajorCategoryType categoryType,
    bool showLoader,
  ) async {
    /// show loading state if enabled in event
    if (showLoader) {
      /// set this to the current category type
      /// category types are drugs and healthcare
      emit(ExploreLoading(state.data.copy(categoryType: categoryType)));
    }

    /// refresh drug if category type is drug
    if (categoryType.isDrug) {
      /// load drug list for the first page
      final result = await repo.loadDrugCategory(
        state.data.filter.copy(page: 0),
      );
      result.fold((left) => emit(ExploreFailed(state.data, left)), (right) {
        emit(ExploreSuccess(state.data.copy(drugProducts: right)));
      });
    } else {
      /// load filter data for the first page
      final result = await repo.loadHealthCareCategory(
        state.data.filter.copy(page: 0),
      );
      result.fold((left) => emit(ExploreFailed(state.data, left)), (right) {
        emit(ExploreSuccess(state.data.copy(healthCareProducts: right)));
      });
    }
  }

  Future<void> nextPage({bool showLoader = false}) async {
    int page = state.data.filter.page;

    /// show loading state if enabled in event
    if (showLoader) emit(ExploreLoading(state.data));

    /// if products is emtpy just reload the current page
    if (state.data.products.isEmpty) {
      page += 1;
    }
    if (state.data.categoryType.isDrug) {
      final result = await repo.loadDrugCategory(state.data.filter);
      result.fold((left) => emit(ExploreFailed(state.data, left)), (right) {
        List<ProductDetail> products = state.data.products;
        products.addAll(right);
        emit(
          ExploreSuccess(
            state.data.copy(
              drugProducts: products,
              filter: state.data.filter.copy(page: page),
            ),
          ),
        );
      });
    } else {
      final result = await repo.loadHealthCareCategory(state.data.filter);
      result.fold((left) => emit(ExploreFailed(state.data, left)), (right) {
        List<ProductDetail> products = state.data.products;
        products.addAll(right);
        emit(
          ExploreSuccess(
            state.data.copy(
              healthCareProducts: products,
              filter: state.data.filter.copy(page: page),
            ),
          ),
        );
      });
    }
  }
}
