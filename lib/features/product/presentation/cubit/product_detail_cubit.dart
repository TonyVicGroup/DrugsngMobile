import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/product/data/repositories/product_repository.dart';
import 'package:drugs_ng/features/product/domain/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drugs_ng/features/product/domain/models/product_detail.dart';
import 'package:equatable/equatable.dart';

class ProductDetailCubit extends Cubit<ProductState> {
  final ProductRepository repo = ProductRepository();
  ProductDetailCubit() : super(const ProductState());

  void changeTab(ProductDetailTabEnum tab) {
    emit(state.copyWith(tab: tab));
  }

  Future getDataFromProduct(Product prod) async {
    emit(state.copyWith(productStatus: LoadStatusEnum.loading));
    final result = await repo.getProduct(prod.id);
    result.fold(
      (l) => emit(state.copyWith(productStatus: LoadStatusEnum.failed)),
      (r) async {
        emit(state.copyWith(productStatus: LoadStatusEnum.success, product: r));
        final similar = await repo.getSimillarProducts(r.name);
        if (similar.isRight) {
          emit(
            state.copyWith(
              similarProdStatus: LoadStatusEnum.success,
              similarProduct: similar.right,
            ),
          );
        }
      },
    );
  }

  Future getData(int id) async {
    emit(state.copyWith(productStatus: LoadStatusEnum.loading));
    final result = await repo.getProduct(id);
    result.fold(
      (l) => emit(state.copyWith(productStatus: LoadStatusEnum.failed)),
      (r) async {
        emit(state.copyWith(productStatus: LoadStatusEnum.success, product: r));
        final similar = await repo.getSimillarProducts(r.name);
        if (similar.isRight) {
          emit(
            state.copyWith(
              similarProdStatus: LoadStatusEnum.success,
              similarProduct: similar.right,
            ),
          );
        }
      },
    );
  }
}

class ProductState extends Equatable {
  final ProductDetail? product;
  final List<Product> similarProduct;
  final LoadStatusEnum productStatus;
  final LoadStatusEnum similarProdStatus;
  final ProductDetailTabEnum tab;
  final String? error;

  const ProductState({
    this.product,
    this.similarProduct = const [],
    this.productStatus = LoadStatusEnum.initial,
    this.similarProdStatus = LoadStatusEnum.initial,
    this.tab = ProductDetailTabEnum.description,
    this.error,
  });

  ProductState copyWith({
    ProductDetail? product,
    List<Product>? similarProduct,
    LoadStatusEnum? productStatus,
    LoadStatusEnum? similarProdStatus,
    ProductDetailTabEnum? tab,
    String? error,
  }) => ProductState(
    product: product ?? this.product,
    similarProduct: similarProduct ?? this.similarProduct,
    productStatus: productStatus ?? this.productStatus,
    similarProdStatus: similarProdStatus ?? this.similarProdStatus,
    tab: tab ?? this.tab,
    error: error ?? this.error,
  );

  @override
  List<Object?> get props => [
    product,
    similarProduct,
    productStatus,
    similarProdStatus,
    tab,
    error,
  ];
}

enum ProductDetailTabEnum {
  description,
  review;

  String get displayName => switch (this) {
    description => 'Descriptions',
    review => 'Review',
  };

  @override
  String toString() => displayName;
}
