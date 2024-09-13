import 'package:flutter/material.dart';

class AdminReclamationScreen extends StatelessWidget {
  const AdminReclamationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Reclamations'),
      ),
      body: ReclamationList(),
    );
  }
}

class ReclamationList extends StatelessWidget {
  // Simulate reclamations list. Replace with real data fetching.
  final List<Map<String, String>> reclamations = [
    {
      'id': '1',
      'clientName': 'Client 1',
      'order': 'Order 1',
      'status': 'Pending'
    },
    {
      'id': '2',
      'clientName': 'Client 2',
      'order': 'Order 2',
      'status': 'Resolved'
    },
    {
      'id': '3',
      'clientName': 'Client 3',
      'order': 'Order 3',
      'status': 'In Progress'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reclamations.length,
      itemBuilder: (context, index) {
        final reclamation = reclamations[index];
        return ListTile(
          title: Text('Reclamation from ${reclamation['clientName']}'),
          subtitle: Text(
              'Related to: ${reclamation['order']}\nStatus: ${reclamation['status']}'),
          isThreeLine: true,
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Show options like mark as resolved, delete
            },
          ),
          onTap: () {
            // Navigate to details page of the reclamation
          },
        );
      },
    );
  }
}
