part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  final HomeData data;

  const HomeState(this.data);

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
  final String message;
  const HomeError(super.data, this.message);

  @override
  List<Object> get props => [message, data];
}
