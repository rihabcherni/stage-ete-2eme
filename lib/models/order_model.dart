import 'package:flutter/material.dart';

class Order {
  final String id;
  final String clientId;
  final String origin;
  final String destination;
  final String status;
  final List<OrderItem> orderItems;
  final DateTime? estimatedDeliveryTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.clientId,
    required this.origin,
    required this.destination,
    required this.status,
    required this.orderItems,
    this.estimatedDeliveryTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      clientId: json['clientId'],
      origin: json['origin'],
      destination: json['destination'],
      status: json['status'],
      orderItems: (json['orderItem'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      estimatedDeliveryTime: json['estimatedDeliveryTime'] != null
          ? DateTime.parse(json['estimatedDeliveryTime'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'clientId': clientId,
      'origin': origin,
      'destination': destination,
      'status': status,
      'orderItem': orderItems.map((item) => item.toJson()).toList(),
      'estimatedDeliveryTime': estimatedDeliveryTime?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class OrderItem {
  final String itemName;
  final int quantity;
  final String unit;

  OrderItem({
    required this.itemName,
    required this.quantity,
    required this.unit,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      itemName: json['itemName'],
      quantity: json['quantity'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'quantity': quantity,
      'unit': unit,
    };
  }
}
