import 'package:flutter/material.dart';
import 'package:frontend/models/reclamation.dart';
import 'package:frontend/services/reclamations_service.dart';

class ClientReclamationsScreen extends StatefulWidget {
  final String clientId;

  ClientReclamationsScreen({required this.clientId});

  @override
  _ClientReclamationsScreenState createState() => _ClientReclamationsScreenState();
}

class _ClientReclamationsScreenState extends State<ClientReclamationsScreen> {
  final ReclamationService _reclamationService = ReclamationService();
  List<Reclamation> _reclamations = [];

  @override
  void initState() {
    super.initState();
    _fetchReclamations();
  }

  Future<void> _fetchReclamations() async {
    try {
      final data = await _reclamationService.getClientReclamations(widget.clientId);
      setState(() {
        _reclamations = data;
      });
    } catch (e) {
      // Handle error
    }
  }

  // Add new reclamation
  void _addReclamation() async {
    // Show dialog or form to add a new reclamation
    // Use _reclamationService.createReclamation(Reclamation(...)) to save
  }

  // Update existing reclamation
  void _updateReclamation(String id, Reclamation reclamation) async {
    // Show dialog or form to update the reclamation
    // Use _reclamationService.updateReclamation(id, reclamation) to update
  }

  // Delete a reclamation
  void _deleteReclamation(String id) async {
    try {
      await _reclamationService.deleteReclamation(id);
      _fetchReclamations();  // Refresh list
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Reclamations')),
      body: ListView.builder(
        itemCount: _reclamations.length,
        itemBuilder: (context, index) {
          final reclamation = _reclamations[index];
          return ListTile(
            title: Text(reclamation.message),
            subtitle: Text('Status: ${reclamation.status}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _updateReclamation(reclamation.id, reclamation),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteReclamation(reclamation.id),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addReclamation,
      ),
    );
  }
}
