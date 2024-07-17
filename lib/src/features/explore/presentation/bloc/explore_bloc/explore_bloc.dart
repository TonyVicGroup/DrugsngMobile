import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:drugs_ng/src/core/data/models/product_detail.dart';
import 'package:drugs_ng/src/core/enum/sort_type_enum.dart';
import 'package:drugs_ng/src/features/explore/data/repository/explore_repository.dart';
import 'package:drugs_ng/src/features/explore/presentation/cubit/explore_major_category_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final ExploreRepository repo;

  ExploreBloc(this.repo) : super(ExploreInitial()) {
    on<LoadDrugEvent>(_loadDrugData);
    on<RefreshCategoryEvent>(_refreshCategory);
    on<LoadHealthCareEvent>(_loadHealthCareData);
    on<ToggleGridEvent>(_toggle);
    on<ChangeExploreSort>(_sort);
  }

  Future _loadDrugData(LoadDrugEvent event, Emitter<ExploreState> emit) async {
    emit(ExploreLoading(
      state.drugProducts,
      state.healthCareProducts,
      state.categoryType,
      state.isGrid,
      state.sortType,
    ));
    final result = await repo.loadDrugCategory();
    result.fold(
      (left) => emit(ExploreFailed(
        state.drugProducts,
        state.healthCareProducts,
        state.categoryType,
        state.isGrid,
        state.sortType,
        left,
      )),
      (right) {
        emit(ExploreSuccess(
          drugProducts: right,
          healthCareProducts: state.healthCareProducts,
          categoryType: state.categoryType,
          isGrid: state.isGrid,
          sortType: state.sortType,
        ));
      },
    );
  }

  Future _loadHealthCareData(
      LoadHealthCareEvent event, Emitter<ExploreState> emit) async {
    emit(ExploreLoading(
      state.drugProducts,
      state.healthCareProducts,
      state.categoryType,
      state.isGrid,
      state.sortType,
    ));
    final result = await repo.loadHealthCareCategory();
    result.fold(
      (left) => emit(ExploreFailed(
        state.drugProducts,
        state.healthCareProducts,
        state.categoryType,
        state.isGrid,
        state.sortType,
        left,
      )),
      (right) {
        emit(ExploreSuccess(
          drugProducts: state.drugProducts,
          healthCareProducts: right,
          categoryType: state.categoryType,
          isGrid: state.isGrid,
          sortType: state.sortType,
        ));
      },
    );
  }

  void _toggle(ToggleGridEvent event, Emitter<ExploreState> emit) async {
    emit(ExploreSuccess(
      drugProducts: state.drugProducts,
      healthCareProducts: state.healthCareProducts,
      categoryType: state.categoryType,
      isGrid: !state.isGrid,
      sortType: state.sortType,
    ));
  }

  void _sort(ChangeExploreSort event, Emitter<ExploreState> emit) async {
    emit(ExploreSuccess(
      drugProducts: state.drugProducts,
      healthCareProducts: state.healthCareProducts,
      categoryType: state.categoryType,
      isGrid: state.isGrid,
      sortType: event.sortType,
    ));
  }

  void _refreshCategory(
      RefreshCategoryEvent event, Emitter<ExploreState> emit) async {
    if (event.categoryType == MajorCategoryType.drug) {
      if (!event.forceReload && state.drugProducts.isNotEmpty) {
        return;
      }
      final result = await repo.loadDrugCategory();
      result.fold(
        (left) => emit(ExploreFailed(
          state.drugProducts,
          state.healthCareProducts,
          event.categoryType,
          state.isGrid,
          state.sortType,
          left,
        )),
        (right) {
          emit(ExploreSuccess(
            drugProducts: right,
            healthCareProducts: state.healthCareProducts,
            categoryType: event.categoryType,
            isGrid: state.isGrid,
            sortType: state.sortType,
          ));
        },
      );
    } else {
      if (!event.forceReload && state.healthCareProducts.isNotEmpty) {
        return;
      }
      final result = await repo.loadHealthCareCategory();
      result.fold(
        (left) => emit(ExploreFailed(
          state.drugProducts,
          state.healthCareProducts,
          event.categoryType,
          state.isGrid,
          state.sortType,
          left,
        )),
        (right) {
          emit(ExploreSuccess(
            drugProducts: state.drugProducts,
            healthCareProducts: right,
            categoryType: event.categoryType,
            isGrid: state.isGrid,
            sortType: state.sortType,
          ));
        },
      );
    }
  }
}
