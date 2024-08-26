import 'package:flutter/material.dart';

class ClientDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            DashboardCard(
              title: 'Total Sales',
              value: '\$10,000',
              icon: Icons.monetization_on,
            ),
            DashboardCard(
              title: 'New Clients',
              value: '150',
              icon: Icons.person_add,
            ),
            DashboardCard(
              title: 'Pending Orders',
              value: '25',
              icon: Icons.shopping_cart,
            ),
            DashboardCard(
              title: 'Completed Projects',
              value: '48',
              icon: Icons.check_circle,
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, size: 50),
        title: Text(title),
        subtitle: Text(value, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
