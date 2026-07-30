import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  static const String _itemsKey = "items";
  static const String _subtotalKey = "subtotal";
  static const String _deliveryFeeKey = "deliveryFee";
  static const String _totalKey = "total";

  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;

  const Cart({
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
  });

  factory Cart.initial() =>
      const Cart(items: [], subtotal: 0, deliveryFee: 0, total: 0);

  factory Cart.fromJson(Map json) {
    num total = json[_totalKey];
    num subtotal = json[_subtotalKey];
    num deliveryFee = json[_deliveryFeeKey];

    return Cart(
      items:
          List<Map>.from(
            json[_itemsKey],
          ).map((e) => CartItem.fromJson(e)).toList(),
      subtotal: subtotal.toDouble(),
      deliveryFee: deliveryFee.toDouble(),
      total: total.toDouble(),
    );
  }

  Cart copy({
    List<CartItem>? items,
    double? subtotal,
    double? deliveryFee,
    double? total,
  }) => Cart(
    items: items ?? this.items,
    subtotal: subtotal ?? this.subtotal,
    deliveryFee: deliveryFee ?? this.deliveryFee,
    total: total ?? this.total,
  );

  int get totalItems => items.fold(0, (prev, item) => item.quantity + prev);

  @override
  List<Object?> get props => [items, total, deliveryFee, subtotal];
}

class CartItem extends Equatable {
  static const String _itemIdKey = "itemId";
  static const String _nameKey = "name";
  static const String _sizeKey = "size";
  static const String _formKey = "form";
  static const String _quantityKey = "quantity";
  static const String _amountKey = "amount";
  static const String _urlKey = "url";
  static const String _typeKey = "type";

  final int itemId;
  final String name;
  final String size;
  final String? form;
  final int quantity;
  final double amount;
  final String? url;
  final String? type;

  const CartItem({
    required this.itemId,
    required this.name,
    required this.size,
    required this.form,
    required this.quantity,
    required this.amount,
    required this.url,
    required this.type,
  });

  factory CartItem.fromJson(Map json) {
    num amountNum = json[_amountKey];
    return CartItem(
      itemId: json[_itemIdKey],
      name: json[_nameKey],
      size: json[_sizeKey],
      form: json[_formKey],
      quantity: json[_quantityKey],
      amount: amountNum.toDouble(),
      url: json[_urlKey],
      type: json[_typeKey],
    );
  }

  Map<String, dynamic> toJson() => {
    _itemIdKey: itemId,
    _nameKey: name,
    _sizeKey: size,
    _formKey: form,
    _quantityKey: quantity,
    _amountKey: amount,
    _urlKey: url,
    _typeKey: type,
    'itemType': type,
  };

  CartItem copy({
    int? itemId,
    String? name,
    String? size,
    String? form,
    int? quantity,
    double? amount,
    String? url,
    String? type,
  }) => CartItem(
    itemId: itemId ?? this.itemId,
    name: name ?? this.name,
    size: size ?? this.size,
    form: form ?? this.form,
    quantity: quantity ?? this.quantity,
    amount: amount ?? this.amount,
    url: url ?? this.url,
    type: type ?? this.type,
  );

  double get totalPrice => amount * quantity;

  @override
  List<Object?> get props => [
    itemId,
    name,
    size,
    form,
    quantity,
    amount,
    url,
    type,
  ];
}
