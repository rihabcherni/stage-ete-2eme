import 'dart:convert';
import 'package:frontend/utils/constant.dart';
import 'package:http/http.dart' as http;
import '../models/reclamation.dart';

class ReclamationService {
  final String baseUrl = '$backendUrl/api/reclamations';

  // Get all reclamations (for admin)
  Future<List<Reclamation>> getAllReclamations() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((reclamation) => Reclamation.fromJson(reclamation)).toList();
    } else {
      throw Exception('Failed to load reclamations');
    }
  }

  // Get reclamations for a specific client
  Future<List<Reclamation>> getClientReclamations(String clientId) async {
    final response = await http.get(Uri.parse('$baseUrl/client/$clientId'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((reclamation) => Reclamation.fromJson(reclamation)).toList();
    } else {
      throw Exception('Failed to load client reclamations');
    }
  }

  // Create a new reclamation
  Future<void> createReclamation(Reclamation reclamation) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(reclamation.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create reclamation');
    }
  }

  // Update a reclamation (for clients to update their message)
  Future<void> updateReclamation(String id, Reclamation reclamation) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(reclamation.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update reclamation');
    }
  }

  // Delete a reclamation
  Future<void> deleteReclamation(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete reclamation');
    }
  }

  // Admin updates status of a reclamation
  Future<void> updateReclamationStatus(String id, String status) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'status': status}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update status');
    }
  }
}
