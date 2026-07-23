import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/features/checkout/data/models/cart.dart';
import 'package:drugs_ng/features/checkout/data/models/order_information.dart';
import 'package:drugs_ng/features/checkout/data/models/order_response.dart';
import 'package:drugs_ng/features/checkout/data/models/payment_link_model.dart';
import 'package:drugs_ng/features/checkout/data/repositories/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo repo = CartRepo();
  CartCubit() : super(CartStateInitial());

  Future getCart() async {
    emit(CartStateLoading(state.cart));
    final result = await repo.getCart();
    result.fold(
      (left) {
        emit(CartStateError(state.cart, left));
      },
      (right) {
        emit(CartStateSuccess(right));
      },
    );
  }

  Future increase(String itemName, int productId, int quantity) async {
    emit(CartStateLoading(state.cart));
    final result = await repo.increase(itemName, productId, quantity);
    result.fold(
      (left) {
        emit(CartStateError(state.cart, left));
      },
      (right) {
        emit(CartStateSuccess(right));
        // double price = 0;
        // List<CartItem> cartList = state.cart.items.map((ct) {
        //   if ((ct.itemId == productId) &&
        //       (ct.name.toLowerCase() == itemName.toLowerCase())) {
        //     price = ct.amount;
        //     return ct.copy(quantity: ct.quantity + quantity);
        //   } else {
        //     return ct;
        //   }
        // }).toList();
        // emit(CartStateSuccess(state.cart.copy(
        //   items: cartList,
        //   total: state.cart.total + price,
        //   subtotal: state.cart.subtotal + price,
        // )));
      },
    );
  }

  Future decrease(String itemName, int productId, int quantity) async {
    emit(CartStateLoading(state.cart));
    final result = await repo.decrease(itemName, productId, quantity);
    result.fold(
      (left) {
        emit(CartStateError(state.cart, left));
      },
      (right) {
        emit(CartStateSuccess(right));

        // double price = 0;
        // List<CartItem> cartList = state.cart.items.map((ct) {
        //   if ((ct.itemId == productId) &&
        //       (ct.name.toLowerCase() == itemName.toLowerCase())) {
        //     price = ct.amount;
        //     return ct.copy(quantity: ct.quantity - quantity);
        //   } else {
        //     return ct;
        //   }
        // }).toList();
        // emit(CartStateSuccess(state.cart.copy(
        //   items: cartList,
        //   total: state.cart.total - price,
        //   subtotal: state.cart.subtotal - price,
        // )));
      },
    );
  }

  Future clearCart() async {
    emit(CartStateSuccess(Cart.initial()));
    // emit(CartStateLoading(state.cart));
    final result = await repo.clearCart();
    result.fold(
      (left) {
        emit(CartStateError(state.cart, left));
      },
      (right) {
        // emit(CartStateSuccess(Cart.initial()));
      },
    );
  }

  Future<bool> addItem(CartItem cart) async {
    emit(CartStateLoading(state.cart));
    final result = await repo.addItem(cart);
    if (result.isLeft) {
      emit(CartStateError(state.cart, result.left));
      return false;
    } else {
      emit(CartStateSuccess(result.right));
      return true;
    }
  }

  Future removeItem(int productId, String itemName) async {
    emit(CartStateLoading(state.cart));
    final result = await repo.removeItem(productId, itemName);
    result.fold(
      (left) {
        emit(CartStateError(state.cart, left));
      },
      (right) {
        emit(CartStateSuccess(result.right));
      },
    );
  }

  Future<PaymentLinkModel?> placeOrder(OrderInformation orderInfo) async {
    // if (state.orderInformation == null) {
    /// if user has not placed order in database
    /// place order
    final result = await repo.placeOrder(orderInfo);
    result.fold(
      (left) {
        emit(CartStateError(state.cart, left));
      },
      (right) {
        emit(CartStateSuccess(state.cart, orderInformation: result.right));
      },
    );
    // }

    if (state.orderInformation != null) {
      /// if user has placed order in database
      /// request a payment url
      final paymentResult = await repo.getPaymentUrl(
        state.orderInformation!.id,
      );

      if (paymentResult.isRight) {
        /// if payment is complete return payment url
        return paymentResult.right;
      } else {
        emit(
          CartStateError(
            state.cart,
            paymentResult.left,
            orderInformation: state.orderInformation,
          ),
        );
      }
    }
    return null;
  }

  void resetData() {
    emit(CartStateInitial());
  }
}
