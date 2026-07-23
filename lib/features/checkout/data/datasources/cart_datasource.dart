import 'package:drugs_ng/core/services/rest_service.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/checkout/data/models/cart.dart';
import 'package:drugs_ng/features/checkout/data/models/order_information.dart';
import 'package:drugs_ng/features/checkout/data/models/order_response.dart';
import 'package:drugs_ng/features/checkout/data/models/payment_link_model.dart';

class CartDatasource {
  final RestService service = RestService(baseUrl: AppUtils.baseUrl);

  Future<Cart> addItem(CartItem cart) async {
    final response = await service.post(path: 'cart/add', data: cart.toJson());
    if (response.hasError) throw response.error;
    return Cart.fromJson(response.data!['data']);
  }

  Future<void> clearCart() async {
    final response = await service.delete(path: 'cart/clear');
    if (response.hasError) throw response.error;
    return;
  }

  Future<Cart> decrease(String itemName, int productId, int quantity) async {
    final response = await service.post(
      path: 'cart/decrease',
      queryParameters: {
        "itemId": productId,
        "quantity": quantity,
        "name": itemName,
      },
    );
    if (response.hasError) throw response.error;
    return Cart.fromJson(response.data!['data']);
  }

  Future<Cart> getCart() async {
    final response = await service.get(path: 'cart');
    if (response.hasError) throw response.error;
    return Cart.fromJson(response.data!['data']);
  }

  Future<Cart> increase(String itemName, int productId, int quantity) async {
    final response = await service.post(
      path: 'cart/increase',
      queryParameters: {
        "itemId": productId,
        "quantity": quantity,
        "name": itemName,
      },
    );
    if (response.hasError) throw response.error;
    return Cart.fromJson(response.data!['data']);
  }

  Future<Cart> removeItem(int productId, String itemName) async {
    final response = await service.post(
      path: 'cart/remove',
      queryParameters: {"itemId": productId, "name": itemName},
    );
    if (response.hasError) throw response.error;
    return Cart.fromJson(response.data!['data']);
  }

  Future<OrderResponse> placeOrder(OrderInformation orderInfo) async {
    final response = await service.post(
      path: 'order',
      data: orderInfo.toJson(),
    );
    if (response.hasError) throw response.error;

    return OrderResponse.fromJson(response.data!['data']);
  }

  Future<PaymentLinkModel> getPaymentUrl(int orderId) async {
    final response = await service.post(
      path: 'payment/generate-payment-link?orderId=$orderId',
    );
    if (response.hasError) throw response.error;
    return PaymentLinkModel.fromJson(response.data!['data']);
  }
}
