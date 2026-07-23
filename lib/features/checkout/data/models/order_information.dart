import 'package:drugs_ng/features/auth/data/datasource/get_local_token.dart';
import 'package:drugs_ng/features/checkout/data/models/address/user_address.dart';
import 'package:drugs_ng/features/checkout/data/models/cart.dart';

class OrderInformation {
  final String fullname;
  final String phoneNumber;
  final String email;
  final UserAddress address;
  final Cart cart;

  OrderInformation({
    required this.fullname,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.cart,
  });

  Map<String, dynamic> toJson() {
    final userId = UserPreference.getUser()!.userId;
    return {
      "userId": userId,
      "email": email,
      "phoneNumber": phoneNumber,
      "fullName": fullname,
      "deliveryFee": cart.deliveryFee,
      "address": address.toJson(),
      "orderItems": cart.items.map((cItem) => cItem.toJson()).toList(),
    };
  }
}
