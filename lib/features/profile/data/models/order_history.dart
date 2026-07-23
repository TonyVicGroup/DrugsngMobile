import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OrderHistory extends Equatable {
  static const String _idKey = "id";
  static const String _orderReferenceKey = "orderReference";
  static const String _statusKey = "status";
  static const String _dateKey = "date";
  static const String _revenueKey = "revenue";

  final int id;
  final String orderReference;
  final OrderStatus status;
  final String date;
  final double revenue;

  const OrderHistory({
    required this.id,
    required this.orderReference,
    required this.status,
    required this.date,
    required this.revenue,
  });

  factory OrderHistory.fromJson(Map json) {
    num revenue = json[_revenueKey];
    return OrderHistory(
      id: json[_idKey],
      orderReference: json[_orderReferenceKey],
      status: OrderStatus.fromString(json[_statusKey]),
      date: json[_dateKey],
      revenue: revenue.toDouble(),
    );
  }

  @override
  List<Object?> get props => [id, orderReference, status, date, revenue];
}

enum OrderStatus {
  refunded,
  pending,
  inProgress,
  completed;

  factory OrderStatus.fromString(String value) {
    switch (value.toLowerCase()) {
      case "refunded":
        return refunded;
      case "pending":
        return pending;
      case "inProgress":
        return inProgress;
      case "completed":
        return completed;
      default:
        return pending;
      // throw Exception("Invalid order status");
    }
  }

  String get displayName {
    switch (this) {
      case refunded:
        return "Refunded";
      case pending:
        return "Pending";
      case inProgress:
        return "In Progress";
      case completed:
        return "Completed";
    }
  }

  Color get backgroundColor {
    switch (this) {
      case refunded:
        return const Color(0xFFF7E9E9);
      case pending:
        return const Color(0xFFFFBA49).withOpacity(0.12); // change later
      case inProgress:
        return const Color(0xFFFFBA49).withOpacity(0.12);
      case completed:
        return const Color(0xFFEAF7E9);
    }
  }

  Color get borderColor {
    switch (this) {
      case refunded:
        return const Color(0xFFF0D5D3);
      case pending:
        return const Color(0xFFF9DBB8); // change later
      case inProgress:
        return const Color(0xFFF9DBB8);
      case completed:
        return const Color(0xFFD5F0D3);
    }
  }

  Color get color {
    switch (this) {
      case refunded:
        return const Color(0xFFFF5252);
      case pending:
        return const Color(0xFFFFBA49); // change later
      case inProgress:
        return const Color(0xFFFFBA49);
      case completed:
        return const Color(0xFF39C316);
    }
  }

  String get icon {
    switch (this) {
      case refunded:
        return AppSvg.closeCircle;
      case pending:
        return AppSvg.inProgress; // change later
      case inProgress:
        return AppSvg.inProgress;
      case completed:
        return AppSvg.checkCircle;
    }
  }
}
