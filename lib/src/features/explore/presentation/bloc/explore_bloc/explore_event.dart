part of 'explore_bloc.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object> get props => [];
}

class LoadExploreEvent extends ExploreEvent {
  final String title;

  const LoadExploreEvent({required this.title});

  @override
  List<Object> get props => [title];
}

class ToggleGridEvent extends ExploreEvent {}

class ChangeExploreSort extends ExploreEvent {
  final SortTypeEnum sortType;

  const ChangeExploreSort({required this.sortType});

  @override
  List<Object> get props => [sortType];
}
