import 'package:drugs_ng/src/features/product/domain/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:drugs_ng/src/core/data/models/product_detail.dart';
import 'package:drugs_ng/src/features/product/domain/repositories/product_repo.dart';
import 'package:equatable/equatable.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repo;
  ProductCubit(this.repo) : super(ProductInitial());

  Future getData(int id) async {
    emit(ProductLoading());
    final result = await repo.getProduct(id);
    result.fold(
      (l) => emit(ProductError(l)),
      (r) async {
        emit(ProductSuccess(r));
        final similar = await repo.getSimillarProducts(id);
        if (similar.isRight) {
          emit(ProductSuccess(r, similar.right));
        }
      },
    );
  }
}
