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
  final List<Product> similarProduct;

  const ProductSuccess(this.product, [this.similarProduct = const []]);

  ProductSuccess copy({
    ProductDetail? product,
    List<Product>? similarProduct,
  }) =>
      ProductSuccess(
        product ?? this.product,
        similarProduct ?? this.similarProduct,
      );

  @override
  List<Object> get props => [product];
}

class ProductError extends ProductState {
  final AppError error;

  const ProductError(this.error);
}
