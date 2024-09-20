import 'dart:convert';
import 'package:frontend/utils/constant.dart';
import 'package:http/http.dart' as http;

class AdminDashboardService {
  final String apiUrl = '$backendUrl/api/dash-admin/count';

  Future<Map<String, dynamic>> fetchStatistics() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to load statistics');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
