part of 'explore_bloc.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object> get props => [];
}

class ExploreInitial extends ExploreState {}

class ExploreSuccess extends ExploreState {
  final List<Product> products;
  final bool isGrid;
  final String title;
  final SortTypeEnum sortType;

  const ExploreSuccess({
    required this.products,
    required this.isGrid,
    required this.title,
    required this.sortType,
  });

  ExploreSuccess copy(
          {List<Product>? products,
          bool? isGrid,
          String? title,
          SortTypeEnum? sortType}) =>
      ExploreSuccess(
        products: products ?? this.products,
        isGrid: isGrid ?? this.isGrid,
        title: title ?? this.title,
        sortType: sortType ?? this.sortType,
      );

  @override
  List<Object> get props => [products, isGrid, title, sortType];
}

class ExploreLoading extends ExploreState {}

class ExploreFailed extends ExploreState {}
