part of 'explore_bloc.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object> get props => [];
}

class LoadDrugEvent extends ExploreEvent {}

class LoadHealthCareEvent extends ExploreEvent {}

class ToggleGridEvent extends ExploreEvent {}

class RefreshCategoryEvent extends ExploreEvent {
  final MajorCategoryType categoryType;
  final bool forceReload;

  const RefreshCategoryEvent(
      {required this.categoryType, required this.forceReload});

  @override
  List<Object> get props => [categoryType, forceReload];
}

class ChangeExploreSort extends ExploreEvent {
  final SortTypeEnum sortType;

  const ChangeExploreSort({required this.sortType});

  @override
  List<Object> get props => [sortType];
}
