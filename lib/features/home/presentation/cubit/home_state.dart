part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  final HomeData data;

  const HomeState(this.data);

  bool get isEmpty => data.newArrivals.isEmpty && data.bestSellers.isEmpty;

  @override
  List<Object> get props => [data];
}

final class HomeInitial extends HomeState {
  const HomeInitial()
      : super(const HomeData(newArrivals: [], bestSellers: [], homeAds: []));
}

final class HomeSuccess extends HomeState {
  const HomeSuccess(super.data);
}

final class HomeLoading extends HomeState {
  const HomeLoading(super.data);
}

final class HomeError extends HomeState {
  final AppError error;
  const HomeError(super.data, this.error);

  @override
  List<Object> get props => [error, data];
}
