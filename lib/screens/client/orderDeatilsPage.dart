import 'package:flutter/material.dart';
import 'package:frontend/models/order.dart';
import 'package:frontend/services/order_service.dart';


class OrderDetailPage extends StatelessWidget {
  final String orderId;

  OrderDetailPage({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: FutureBuilder<Order>(
        future: OrderService().getOrderById(orderId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Order not found.'));
          } else {
            final order = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Origin: ${order.origin}', style: TextStyle(fontSize: 18)),
                  Text('Destination: ${order.destination}', style: TextStyle(fontSize: 18)),
                  Text('Status: ${order.status}', style: TextStyle(fontSize: 18)),
                  // Add more details as needed
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to edit order page
                    },
                    child: Text('Edit Order'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Confirm and delete order
                    },
                    child: Text('Delete Order'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}