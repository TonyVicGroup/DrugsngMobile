import 'package:drugs_ng/src/core/enum/sort_type_enum.dart';
import 'package:drugs_ng/src/features/explore/data/repository/explore_repository.dart';
import 'package:drugs_ng/src/features/product/domain/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final ExploreRepository repo;

  ExploreBloc(this.repo) : super(ExploreInitial()) {
    on<LoadExploreEvent>(_loadData);
    on<ToggleGridEvent>(_toggle);
    on<ChangeExploreSort>(_sort);
  }

  Future _loadData(LoadExploreEvent event, Emitter<ExploreState> emit) async {
    emit(ExploreLoading());
    final result = await repo.loadCategory(event.title);
    result.fold(
      (left) => emit(ExploreFailed()),
      (right) {
        emit(ExploreSuccess(
          products: right,
          isGrid: true,
          title: event.title,
          sortType: SortTypeEnum.newArrival,
        ));
      },
    );
  }

  void _toggle(ToggleGridEvent event, Emitter<ExploreState> emit) async {
    if (state is ExploreSuccess) {
      final sState = state as ExploreSuccess;
      emit(ExploreSuccess(
          products: sState.products,
          isGrid: !sState.isGrid,
          title: sState.title,
          sortType: sState.sortType));
    }
  }

  void _sort(ChangeExploreSort event, Emitter<ExploreState> emit) async {
    if (state is ExploreSuccess) {
      final sState = state as ExploreSuccess;
      emit(ExploreSuccess(
          products: sState.products,
          isGrid: sState.isGrid,
          title: sState.title,
          sortType: event.sortType));
    }
  }
}
