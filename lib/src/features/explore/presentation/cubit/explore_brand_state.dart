part of 'explore_brand_cubit.dart';

sealed class ExploreBrandState extends Equatable {
  final List<String> brands;
  final List<String> searchResult;
  const ExploreBrandState(this.brands, this.searchResult);

  @override
  List<Object> get props => [brands, searchResult];
}

final class ExploreBrandInitial extends ExploreBrandState {
  const ExploreBrandInitial() : super(const [], const []);
}

final class ExploreBrandLoading extends ExploreBrandState {
  const ExploreBrandLoading(super.brands, super.searchResult);
}

final class ExploreBrandSuccess extends ExploreBrandState {
  const ExploreBrandSuccess(super.brands, super.searchResult);
}

final class ExploreBrandFailed extends ExploreBrandState {
  final String message;
  const ExploreBrandFailed(super.brands, super.searchResult, this.message);
  @override
  List<Object> get props => [message, searchResult, brands];
}
