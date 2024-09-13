import 'package:flutter/material.dart';

class AdminCommandesScreen extends StatelessWidget {
  const AdminCommandesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Commandes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to a screen to add a new commande
            },
          ),
        ],
      ),
      body: CommandeList(),
    );
  }
}

class CommandeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with a real data fetching logic
    final commandes = [
      {'id': '1', 'name': 'Commande 1', 'status': 'Pending'},
      {'id': '2', 'name': 'Commande 2', 'status': 'Delivered'},
      {'id': '3', 'name': 'Commande 3', 'status': 'Shipped'},
    ];

    return ListView.builder(
      itemCount: commandes.length,
      itemBuilder: (context, index) {
        final commande = commandes[index];
        return ListTile(
          title: Text(commande['name'] ?? ''),
          subtitle: Text('Status: ${commande['status']}'),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Show options like edit, delete
            },
          ),
          onTap: () {
            // Navigate to details page of the commande
          },
        );
      },
    );
  }
}
