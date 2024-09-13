import 'dart:convert';
import 'package:frontend/models/order_model.dart';
import 'package:frontend/utils/constant.dart';
import 'package:http/http.dart' as http;

class OrderService {
  OrderService();

  Future<List<Order>> getAllOrders() async {
    final response = await http.get(Uri.parse('$backendUrl/api/order'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((order) => Order.fromJson(order)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<Order> getOrderById(String id) async {
    final response = await http.get(Uri.parse('$backendUrl/api/order/$id'));

    if (response.statusCode == 200) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load order');
    }
  }

  Future<List<Order>> getOrdersByClient(String clientId) async {
    final response =
        await http.get(Uri.parse('$backendUrl/api/order/clients/$clientId'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((order) => Order.fromJson(order)).toList();
    } else {
      throw Exception('Failed to load client orders');
    }
  }

  Future<Order> addOrder(Order order) async {
    final response = await http.post(
      Uri.parse('$backendUrl/api/order'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(order.toJson()),
    );

    if (response.statusCode == 201) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add order');
    }
  }

  Future<Order> updateOrder(String id, Order order) async {
    final response = await http.put(
      Uri.parse('$backendUrl/api/order/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(order.toJson()),
    );

    if (response.statusCode == 200) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update order');
    }
  }

  Future<void> deleteOrder(String id) async {
    final response = await http.delete(Uri.parse('$backendUrl/api/order/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete order');
    }
  }
}
