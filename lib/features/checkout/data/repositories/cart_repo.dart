import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/utils/app_data_types.dart';
import 'package:drugs_ng/features/checkout/data/datasources/cart_datasource.dart';
import 'package:drugs_ng/features/checkout/data/models/cart.dart';
import 'package:drugs_ng/features/checkout/data/models/order_information.dart';
import 'package:drugs_ng/features/checkout/data/models/order_response.dart';
import 'package:drugs_ng/features/checkout/data/models/payment_link_model.dart';
import 'package:either_dart/either.dart';

class CartRepo {
  final CartDatasource datasource = CartDatasource();

  AsyncApiErrorOr<Cart> getCart() async {
    try {
      final result = await datasource.getCart();
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<void> clearCart() async {
    try {
      final result = await datasource.clearCart();
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<Cart> addItem(CartItem cart) async {
    try {
      final result = await datasource.addItem(cart);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<Cart> removeItem(int productId, String itemName) async {
    try {
      final result = await datasource.removeItem(productId, itemName);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<Cart> decrease(
    String itemName,
    int productId,
    int quantity,
  ) async {
    try {
      final result = await datasource.decrease(itemName, productId, quantity);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<Cart> increase(
    String itemName,
    int productId,
    int quantity,
  ) async {
    try {
      final result = await datasource.increase(itemName, productId, quantity);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<OrderResponse> placeOrder(OrderInformation orderInfo) async {
    try {
      final result = await datasource.placeOrder(orderInfo);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }

  AsyncApiErrorOr<PaymentLinkModel> getPaymentUrl(int orderId) async {
    try {
      final result = await datasource.getPaymentUrl(orderId);
      return Right(result);
    } on ApiError catch (e) {
      return Left(e);
    } catch (e) {
      return const Left(ApiError.unknown);
    }
  }
}
