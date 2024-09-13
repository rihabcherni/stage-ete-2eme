import 'package:flutter/material.dart';
import 'package:frontend/models/order_model.dart';
import 'package:frontend/services/order_service.dart';
import 'order_form.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final OrderService orderService = OrderService();

  Future<void> _refreshOrders() async {
    setState(() {});
  }

  void _navigateToForm({Order? order}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderForm(order: order, orderService: orderService),
      ),
    );
    if (result == true) {
      _refreshOrders();
    }
  }

  void _deleteOrder(String id) async {
    await orderService.deleteOrder(id);
    _refreshOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: FutureBuilder<List<Order>>(
        future: orderService.getAllOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final orders = snapshot.data ?? [];
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  title: Text('Order ${order.id}'),
                  subtitle: Text('${order.origin} to ${order.destination}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _navigateToForm(order: order),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteOrder(order.id),
                      ),
                      IconButton(
                        icon: const Icon(Icons.info),
                        onPressed: () {
                          // Show order details
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Order Details'),
                              content: Text(
                                  'Origin: ${order.origin}\nDestination: ${order.destination}\nStatus: ${order.status}\nCreated At: ${order.createdAt}\nUpdated At: ${order.updatedAt}'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Close'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
