import 'dart:convert';
import 'package:frontend/utils/constant.dart';
import 'package:http/http.dart' as http;
import '../models/notification.dart';

class NotificationService {
  static const String baseUrl = '$backendUrl/api/notifications';

  Future<List<AppNotification>> getNotificationsByUser(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/$userId'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<AppNotification> notifications = body
          .map((dynamic item) => AppNotification.fromJson(item))
          .toList();
      return notifications;
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  Future<void> markAsRead(String notificationId) async {
    final response = await http.put(Uri.parse('$baseUrl/$notificationId/read'));

    if (response.statusCode != 200) {
      throw Exception('Failed to mark notification as read');
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$notificationId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete notification');
    }
  }
}
