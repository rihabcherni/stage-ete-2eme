
import 'package:flutter/material.dart';
import 'package:frontend/models/order.dart';
import 'package:frontend/screens/client/orderDeatilsPage.dart';
import 'package:frontend/services/order_service.dart';

class OrderListPage extends StatefulWidget {
  final String clientId;

  OrderListPage({required this.clientId});

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  late Future<List<Order>> _orders;

  @override
  void initState() {
    super.initState();
    _orders = OrderService().getOrdersByClient(widget.clientId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: FutureBuilder<List<Order>>(
        future: _orders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final order = snapshot.data![index];
                return ListTile(
                  title: Text('${order.origin} to ${order.destination}'),
                  subtitle: Text('Status: ${order.status}'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailPage(orderId: order.id),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to order creation page
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
