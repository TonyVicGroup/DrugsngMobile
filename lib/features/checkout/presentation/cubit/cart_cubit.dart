import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/features/checkout/data/models/cart.dart';
import 'package:drugs_ng/features/checkout/data/models/order_information.dart';
import 'package:drugs_ng/features/checkout/data/models/order_response.dart';
import 'package:drugs_ng/features/checkout/data/models/payment_link_model.dart';
import 'package:drugs_ng/features/checkout/data/repositories/cart_repo.dart';
import 'package:drugs_ng/features/lab_test/domain/models/diagnostic_test_detail.dart';
import 'package:drugs_ng/features/lab_test/domain/models/wellness_package_detail.dart';
import 'package:drugs_ng/features/product/domain/models/product.dart';
import 'package:drugs_ng/features/product/domain/models/product_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo repo = CartRepo();
  CartCubit() : super(CartState(cart: Cart.initial()));

  Future getCart() async {
    emit(state.copyWith(getCartStatus: LoadStatusEnum.loading));
    final result = await repo.getCart();
    result.fold(
      (left) {
        emit(
          state.copyWith(
            getCartStatus: LoadStatusEnum.failed,
            error: left.message,
          ),
        );
      },
      (right) {
        emit(
          state.copyWith(getCartStatus: LoadStatusEnum.success, cart: right),
        );
      },
    );
  }

  Future increase(String itemName, int productId, int quantity) async {
    emit(
      state.copyWith(
        updateProductStatus: LoadStatusEnum.loading,
        updatedProdId: productId.toString(),
      ),
    );
    final result = await repo.increase(itemName, productId, quantity);
    result.fold(
      (left) {
        emit(
          state.copyWith(
            updateProductStatus: LoadStatusEnum.failed,
            error: left.message,
            updatedProdId: '',
          ),
        );
      },
      (right) {
        emit(
          state.copyWith(
            updateProductStatus: LoadStatusEnum.success,
            updatedProdId: '',
            cart: right,
          ),
        );
      },
    );
  }

  Future decrease(String itemName, int productId, int quantity) async {
    emit(
      state.copyWith(
        updateProductStatus: LoadStatusEnum.loading,
        updatedProdId: productId.toString(),
      ),
    );
    final result = await repo.decrease(itemName, productId, quantity);
    result.fold(
      (left) {
        emit(
          state.copyWith(
            updateProductStatus: LoadStatusEnum.failed,
            error: left.message,
            updatedProdId: '',
          ),
        );
      },
      (right) {
        emit(
          state.copyWith(
            updateProductStatus: LoadStatusEnum.success,
            updatedProdId: '',
            cart: right,
          ),
        );
      },
    );
  }

  Future clearCart() async {
    emit(
      state.copyWith(
        updateProductStatus: LoadStatusEnum.loading,
        updatedProdId: '',
      ),
    );
    final result = await repo.clearCart();
    result.fold(
      (left) {
        emit(
          state.copyWith(
            updateProductStatus: LoadStatusEnum.failed,
            error: left.message,
          ),
        );
      },
      (right) {
        emit(
          state.copyWith(
            updateProductStatus: LoadStatusEnum.success,
            cart: Cart.initial(),
            updatedProdId: '',
          ),
        );
      },
    );
  }

  Future<bool> addItem(CartItem cart) async {
    emit(
      state.copyWith(
        updateProductStatus: LoadStatusEnum.loading,
        updatedProdId: cart.itemId.toString(),
      ),
    );
    final result = await repo.addItem(cart);
    if (result.isLeft) {
      emit(
        state.copyWith(
          updateProductStatus: LoadStatusEnum.failed,
          updatedProdId: '',
          error: result.left.message,
        ),
      );
      return false;
    } else {
      emit(
        state.copyWith(
          updateProductStatus: LoadStatusEnum.success,
          cart: result.right,
        ),
      );
      return true;
    }
  }

  Future<void> addWithProduct({
    required Product product,
    required int quantity,
  }) async {
    bool exists =
        state.cart.items.indexWhere((ct) {
          return ct.name == product.name && ct.itemId == product.id;
        }) >=
        0;

    if (exists) {
      await increase(product.name, product.id, 1);
    } else {
      await addItem(
        CartItem(
          itemId: product.id,
          name: product.name,
          size: '',
          form: '',
          quantity: quantity,
          amount: product.price,
          url: null,
          type: null,
        ),
      );
    }
  }

  Future<void> addWithProductDetail({
    required ProductDetail product,
    required int quantity,
  }) async {
    bool exists =
        state.cart.items.indexWhere((ct) {
          return ct.name == product.name && ct.itemId == product.id;
        }) >=
        0;

    if (exists) {
      await increase(product.name, product.id, 1);
    } else {
      await addItem(
        CartItem(
          itemId: product.id,
          name: product.name,
          size: product.size,
          form: product.productFormName,
          quantity: 1,
          amount: product.price,
          url: null,
          type: null,
        ),
      );
    }
  }

  Future<void> addWellnessPackage({
    required WellnessPackageDetail package,
    required int quantity,
  }) async {
    bool exists =
        state.cart.items.indexWhere((ct) {
          return ct.name == package.name && ct.itemId == package.id;
        }) >=
        0;
    if (exists) {
      await increase(package.name, package.id, 1);
    } else {
      await addItem(
        CartItem(
          itemId: package.id,
          name: package.name,
          size: "1",
          form: null,
          quantity: quantity,
          amount: package.price,
          url: null,
          type: null,
        ),
      );
    }
  }

  Future<void> addLabTest({
    required DiagnosticTestDetail labTest,
    required int quantity,
  }) async {
    bool exists =
        state.cart.items.indexWhere((ct) {
          return ct.name == labTest.name && ct.itemId == labTest.id;
        }) >=
        0;
    if (exists) {
      await increase(labTest.name, labTest.id, 1);
    } else {
      await addItem(
        CartItem(
          itemId: labTest.id,
          name: labTest.name,
          size: "1",
          form: null,
          quantity: quantity,
          amount: labTest.price,
          url: null,
          type: null,
        ),
      );
    }
  }

  Future removeItem(int productId, String itemName) async {
    emit(
      state.copyWith(
        updateProductStatus: LoadStatusEnum.loading,
        updatedProdId: productId.toString(),
      ),
    );
    final result = await repo.removeItem(productId, itemName);
    result.fold(
      (left) {
        emit(
          state.copyWith(
            updateProductStatus: LoadStatusEnum.failed,
            updatedProdId: '',
            error: left.message,
          ),
        );
      },
      (right) {
        emit(
          state.copyWith(
            updateProductStatus: LoadStatusEnum.success,
            updatedProdId: '',
            cart: right,
          ),
        );
      },
    );
  }

  Future<void> placeOrder(OrderInformation orderInfo) async {
    emit(state.copyWith(orderStatus: LoadStatusEnum.loading));
    final result = await repo.placeOrder(orderInfo);
    result.fold(
      (left) {
        emit(
          state.copyWith(
            orderStatus: LoadStatusEnum.failed,
            error: left.message,
          ),
        );
      },
      (right) {
        emit(
          state.copyWith(
            orderStatus: LoadStatusEnum.success,
            orderInformation: result.right,
          ),
        );
      },
    );
  }

  Future<void> getPaymentUrl() async {
    if (state.orderInformation == null) return;
    emit(state.copyWith(paymentStatus: LoadStatusEnum.loading));
    final paymentResult = await repo.getPaymentUrl(state.orderInformation!.id);
    if (paymentResult.isRight) {
      emit(
        state.copyWith(
          paymentStatus: LoadStatusEnum.success,
          paymentLink: paymentResult.right,
        ),
      );
    } else {
      emit(
        state.copyWith(
          paymentStatus: LoadStatusEnum.failed,
          error: paymentResult.left.message,
        ),
      );
    }
  }

  void resetData() {
    emit(CartState(cart: Cart.initial()));
  }
}

class CartState extends Equatable {
  final Cart cart;
  final OrderResponse? orderInformation;
  final LoadStatusEnum getCartStatus;
  final LoadStatusEnum updateProductStatus;
  final LoadStatusEnum orderStatus;
  final String updatedProdId;
  final PaymentLinkModel? paymentLink;
  final LoadStatusEnum paymentStatus;
  final String? error;

  const CartState({
    required this.cart,
    this.orderInformation,
    this.getCartStatus = LoadStatusEnum.initial,
    this.updateProductStatus = LoadStatusEnum.initial,
    this.orderStatus = LoadStatusEnum.initial,
    this.updatedProdId = '',
    this.paymentLink,
    this.paymentStatus = LoadStatusEnum.initial,
    this.error,
  });

  CartState copyWith({
    Cart? cart,
    OrderResponse? orderInformation,
    LoadStatusEnum? getCartStatus,
    LoadStatusEnum? updateProductStatus,
    LoadStatusEnum? orderStatus,
    String? updatedProdId,
    PaymentLinkModel? paymentLink,
    LoadStatusEnum? paymentStatus,
    String? error,
    bool resetOrder = false,
  }) => CartState(
    cart: cart ?? this.cart,
    getCartStatus: getCartStatus ?? this.getCartStatus,
    updateProductStatus: updateProductStatus ?? this.updateProductStatus,
    updatedProdId: updatedProdId ?? this.updatedProdId,
    orderInformation:
        resetOrder ? null : orderInformation ?? this.orderInformation,
    orderStatus:
        resetOrder ? LoadStatusEnum.initial : (orderStatus ?? this.orderStatus),
    paymentLink: resetOrder ? null : (paymentLink ?? this.paymentLink),
    paymentStatus:
        resetOrder
            ? LoadStatusEnum.initial
            : (paymentStatus ?? this.paymentStatus),
    error: error ?? this.error,
  );

  double totalPrice() => cart.total;

  int totalItems() => cart.items.fold(0, (prev, ct) => prev + ct.quantity);

  @override
  List<Object?> get props => [
    cart,
    orderInformation,
    getCartStatus,
    updateProductStatus,
    updatedProdId,
    orderStatus,
    paymentLink,
    paymentStatus,
    error,
  ];
}
