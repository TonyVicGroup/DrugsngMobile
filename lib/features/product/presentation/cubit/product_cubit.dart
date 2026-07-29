import 'package:drugs_ng/features/product/data/repositories/product_repository.dart';
import 'package:drugs_ng/features/product/domain/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/features/product/domain/models/product_detail.dart';
import 'package:equatable/equatable.dart';

part 'product_product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repo = ProductRepository();
  ProductCubit() : super(ProductInitial());

  Future getData(int id) async {
    emit(ProductLoading());
    final result = await repo.getProduct(id);
    result.fold((l) => emit(ProductError(l)), (r) async {
      emit(ProductSuccess(r));
      final similar = await repo.getSimillarProducts(r.name);
      if (similar.isRight) {
        emit(ProductSuccess(r, similar.right));
      }
    });
  }
}
