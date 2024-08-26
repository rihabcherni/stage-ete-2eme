import 'dart:convert';
import 'package:frontend/models/userMessage.dart';
import 'package:http/http.dart' as http;

Future<List<UserMessage>> fetchUsers() async {
  final response = await http.get(Uri.parse('http://localhost:5000/api/message/users'));

  if (response.statusCode == 200) {
    List<dynamic> body = json.decode(response.body);
    List<UserMessage> users = body.map((dynamic item) => UserMessage.fromJson(item)).toList();
    return users;
  } else {
    throw Exception('Failed to load users');
  }
}
