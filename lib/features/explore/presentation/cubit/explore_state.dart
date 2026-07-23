part of 'explore_cubit.dart';

abstract class ExploreState extends Equatable {
  final ExploreData data;

  const ExploreState(this.data);

  @override
  List<Object> get props => [data];
}

class ExploreInitial extends ExploreState {
  ExploreInitial() : super(ExploreData.initial());
}

class ExploreSuccess extends ExploreState {
  const ExploreSuccess(super.data);
}

class ExploreLoading extends ExploreState {
  const ExploreLoading(super.data);
}

class ExploreFailed extends ExploreState {
  final AppError error;

  const ExploreFailed(super.data, this.error);

  @override
  List<Object> get props => [data, error];
}
