class OrderDetailModel {
  final int id;
  final String orderReference;
  final int userId;
  final int addressId;
  final String status;
  final double total;
  final String? arrivalDate;
  final String customerName;
  final String address;
  final String phoneNumber;
  final String email;
  final DateTime? dateCreated;
  final String? paymentReference;
  final String? paymentStatus;
  final List<OrderItemModel> orderItems;
  final List<OrderActivityModel> orderActivities;
  final List<OrderRefundRequestModel> orderRefundRequests;

  OrderDetailModel({
    required this.id,
    required this.orderReference,
    required this.userId,
    required this.addressId,
    required this.status,
    required this.total,
    this.arrivalDate,
    required this.customerName,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.dateCreated,
    this.paymentReference,
    this.paymentStatus,
    required this.orderItems,
    required this.orderActivities,
    required this.orderRefundRequests,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      id: json['id'] as int,
      orderReference: json['orderReference'] as String,
      userId: json['userId'] as int,
      addressId: json['addressId'] as int,
      status: json['status'] as String,
      total: (json['total'] as num).toDouble(),
      arrivalDate: json['arrivalDate'] as String?,
      customerName: json['customerName'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      dateCreated:
          json['dateCreated'] != null
              ? DateTime.parse(json['dateCreated'])
              : null,
      paymentReference: json['paymentReference'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      orderItems:
          (json['orderItems'] as List)
              .map(
                (item) => OrderItemModel.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
      orderActivities:
          (json['orderActivities'] as List)
              .map(
                (activity) => OrderActivityModel.fromJson(
                  activity as Map<String, dynamic>,
                ),
              )
              .toList(),
      orderRefundRequests:
          (json['orderRefundRequests'] as List)
              .map(
                (request) => OrderRefundRequestModel.fromJson(
                  request as Map<String, dynamic>,
                ),
              )
              .toList(),
    );
  }
}

class OrderItemModel {
  final int itemId;
  final String name;
  final String type;
  final double price;
  final int itemQty;
  final String? imageUrl;
  final int? tagId;
  final String genericName;

  OrderItemModel({
    required this.itemId,
    required this.name,
    required this.type,
    required this.price,
    required this.itemQty,
    this.imageUrl,
    required this.tagId,
    required this.genericName,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      itemId: json['itemId'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      price: (json['price'] as num).toDouble(),
      itemQty: json['itemQty'] as int,
      imageUrl: json['imageUrl'] as String?,
      tagId: json['tagId'] as int?,
      genericName: json['genericName'] as String,
    );
  }
}

class OrderActivityModel {
  final int id;
  final String name;
  final String description;
  final int orderId;
  final DateTime? dateCreated;

  OrderActivityModel({
    required this.id,
    required this.name,
    required this.description,
    required this.orderId,
    required this.dateCreated,
  });

  factory OrderActivityModel.fromJson(Map<String, dynamic> json) {
    return OrderActivityModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      orderId: json['orderId'] as int,
      dateCreated: DateTime.tryParse(json['dateCreated'] as String? ?? ''),
    );
  }
}

class OrderRefundRequestModel {
  // Add fields based on your refund request structure

  OrderRefundRequestModel();

  factory OrderRefundRequestModel.fromJson(Map<String, dynamic> json) {
    return OrderRefundRequestModel();
  }
}
