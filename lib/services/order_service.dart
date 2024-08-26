import 'dart:convert';
import 'package:frontend/models/order.dart';
import 'package:frontend/utils/constant.dart';
import 'package:http/http.dart' as http;

class OrderService {
  final String baseUrl =  '$backendUrl/api/order';

  Future<List<Order>> getOrdersByClient(String clientId) async {
    final response = await http.get(Uri.parse('$baseUrl/clients/$clientId/orders'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<Order> getOrderById(String orderId) async {
    final response = await http.get(Uri.parse('$baseUrl/orders/$orderId'));

    if (response.statusCode == 200) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load order');
    }
  }

  Future<Order> addOrder(Order order) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(order.toJson()),
    );

    if (response.statusCode == 201) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add order');
    }
  }

  Future<Order> updateOrder(String orderId, Order order) async {
    final response = await http.put(
      Uri.parse('$baseUrl/orders/$orderId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(order.toJson()),
    );

    if (response.statusCode == 200) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update order');
    }
  }

  Future<void> deleteOrder(String orderId) async {
    final response = await http.delete(Uri.parse('$baseUrl/orders/$orderId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete order');
    }
  }
}
