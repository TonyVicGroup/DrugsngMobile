part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  final Cart cart;
  final OrderResponse? orderInformation;
  // final String? paymentUrl;

  const CartState(
    this.cart, {
    this.orderInformation,
    // this.paymentUrl,
  });

  double totalPrice() => cart.total;

  int totalItems() => cart.items.fold(0, (prev, ct) => prev + ct.quantity);

  @override
  List<Object> get props => [
        cart,
        orderInformation ?? '',
        // paymentUrl ?? '',
      ];
}

class CartStateInitial extends CartState {
  CartStateInitial() : super(Cart.initial());
}

class CartStateLoading extends CartState {
  const CartStateLoading(
    super.cart, {
    super.orderInformation,
  });
}

class CartStateSuccess extends CartState {
  const CartStateSuccess(
    super.cart, {
    super.orderInformation,
    // super.paymentUrl,
  });
}

class CartStateError extends CartState {
  final AppError error;
  const CartStateError(
    super.cart,
    this.error, {
    super.orderInformation,
    // super.paymentUrl,
  });

  @override
  List<Object> get props => [cart, error];
}
