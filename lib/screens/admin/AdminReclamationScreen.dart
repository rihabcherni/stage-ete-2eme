import 'package:flutter/material.dart';
import 'package:frontend/models/reclamation.dart';
import 'package:frontend/services/reclamations_service.dart';

class AdminReclamationScreen extends StatefulWidget {
  @override
  _AdminReclamationScreenState createState() =>
      _AdminReclamationScreenState();
}

class _AdminReclamationScreenState extends State<AdminReclamationScreen> {
  final ReclamationService _reclamationService = ReclamationService();
  List<Reclamation> _reclamations = [];

  @override
  void initState() {
    super.initState();
    _fetchReclamations();
  }

  Future<void> _fetchReclamations() async {
    try {
      final data = await _reclamationService.getAllReclamations();
      setState(() {
        _reclamations = data;
      });
    } catch (e) {
      // Handle error
    }
  }

  // Update status of reclamation
  void _updateReclamationStatus(String id, String status) async {
    try {
      await _reclamationService.updateReclamationStatus(id, status);
      _fetchReclamations(); // Refresh list
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Reclamations')),
      body: ListView.builder(
        itemCount: _reclamations.length,
        itemBuilder: (context, index) {
          final reclamation = _reclamations[index];
          return ListTile(
            title: Text(reclamation.message),
            subtitle: Text('Status: ${reclamation.status}'),
            trailing: DropdownButton<String>(
              value: reclamation.status,
              onChanged: (newStatus) =>
                  _updateReclamationStatus(reclamation.id, newStatus!),
              items: ['Pending', 'In Progress', 'Resolved'].map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
