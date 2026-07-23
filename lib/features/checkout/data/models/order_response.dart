class OrderResponse {
  static const String _idKey = "id";
  static const String _orderReferenceKey = "orderReference";
  static const String _statusKey = "status";
  static const String _dateKey = "date";
  static const String _revenueKey = "revenue";

  final int id;
  final String orderReference;
  final String status;
  final String date;
  final double revenue;

  OrderResponse({
    required this.id,
    required this.orderReference,
    required this.status,
    required this.date,
    required this.revenue,
  });

  factory OrderResponse.fromJson(Map json) {
    return OrderResponse(
      id: json[_idKey],
      orderReference: json[_orderReferenceKey],
      status: json[_statusKey],
      date: json[_dateKey],
      revenue: json[_revenueKey],
    );
  }

  OrderResponse copy({
    int? id,
    String? orderReference,
    String? status,
    String? date,
    double? revenue,
    String? paymentUrl,
  }) =>
      OrderResponse(
        id: id ?? this.id,
        orderReference: orderReference ?? this.orderReference,
        status: status ?? this.status,
        date: date ?? this.date,
        revenue: revenue ?? this.revenue,
      );

  Map<String, dynamic> toJson() {
    return {
      _idKey: id,
      _orderReferenceKey: orderReference,
      _statusKey: status,
      _dateKey: date,
      _revenueKey: revenue
    };
  }
}
