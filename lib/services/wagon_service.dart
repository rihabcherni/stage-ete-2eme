import 'dart:convert';
import 'package:frontend/models/wagon_model.dart';
import 'package:frontend/utils/constant.dart';
import 'package:http/http.dart' as http;

class WagonService {
  final String _baseUrl = '$backendUrl/api/wagon'; 

  Future<List<Wagon>> getWagonsByTrainId(String trainId) async {
    final response = await http.get(Uri.parse('$_baseUrl/train/$trainId'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Wagon.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load wagons');
    }
  }

  Future<void> addWagon(Wagon wagon) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(wagon.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add wagon');
    }
  }

  Future<void> updateWagon(String id, Wagon wagon) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(wagon.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update wagon');
    }
  }

  Future<void> deleteWagon(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete wagon');
    }
  }
}
