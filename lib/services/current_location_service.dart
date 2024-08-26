import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrentLocationService {
  static const String _baseUrl = 'http://your-backend-url.com/api';

  Future<List<dynamic>> getAllCurrentLocations() async {
    final response = await http.get(Uri.parse('$_baseUrl/currentLocations'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load current locations');
    }
  }

  Future<dynamic> getCurrentLocationById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/currentLocations/$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load current location');
    }
  }

  Future<void> addCurrentLocation(Map<String, dynamic> locationData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/currentLocations'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(locationData),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add current location');
    }
  }

  Future<void> updateCurrentLocation(String id, Map<String, dynamic> locationData) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/currentLocations/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(locationData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update current location');
    }
  }

  Future<void> deleteCurrentLocation(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/currentLocations/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete current location');
    }
  }
}
