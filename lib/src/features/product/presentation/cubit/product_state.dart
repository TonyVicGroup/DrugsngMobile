part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final ProductDetail product;

  const ProductSuccess(this.product);

  @override
  List<Object> get props => [product];
}

class ProductError extends ProductState {
  final AppError error;

  const ProductError(this.error);
}
