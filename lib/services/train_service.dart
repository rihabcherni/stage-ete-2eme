import 'dart:convert';
import 'package:frontend/utils/constant.dart';
import 'package:http/http.dart' as http;
import '../models/train_model.dart';

class TrainService {
  static const String _baseUrl = '$backendUrl/api/trains';

  Future<List<Train>> getAllTrains() async {
    final response = await http.get(Uri.parse('$_baseUrl/trains'));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((train) => Train.fromJson(train)).toList();
    } else {
      throw Exception('Failed to load trains');
    }
  }

  Future<Train> getTrainById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/trains/$id'));
    if (response.statusCode == 200) {
      return Train.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load train');
    }
  }

  Future<void> addTrain(Train train) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/trains'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'train_reference': train.trainReference,
        'status': train.status,
        'modele_train': train.modeleTrain,
        'carbonEmissions': train.carbonEmissions,
        'serviceStartDate': train.serviceStartDate.toIso8601String(),
        'createdAt': train.createdAt.toIso8601String(),
        'updatedAt': train.updatedAt.toIso8601String(),
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add train: ${response.body}');
    }
  }

  Future<void> updateTrain(String id, Train train) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/trains/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(train.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update train: ${response.body}');
    }
  }

  Future<void> deleteTrain(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/trains/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete train: ${response.body}');
    }
  }
}
