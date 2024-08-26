import 'package:flutter/material.dart';
import '../models/notification.dart';
import '../services/notification_service.dart';

class NotificationProvider with ChangeNotifier {
  List<AppNotification> _notifications = [];
  final NotificationService _notificationService = NotificationService();

  List<AppNotification> get notifications => _notifications;

  Future<void> fetchNotifications(String userId) async {
    _notifications = await _notificationService.getNotificationsByUser(userId);
    notifyListeners();
  }

  Future<void> markAsRead(String notificationId) async {
    await _notificationService.markAsRead(notificationId);
    _notifications = _notifications.map((notification) {
      if (notification.id == notificationId) {
        return AppNotification(
          id: notification.id,
          userId: notification.userId,
          message: notification.message,
          read: true,
          createdAt: notification.createdAt,
        );
      }
      return notification;
    }).toList();
    notifyListeners();
  }

  Future<void> deleteNotification(String notificationId) async {
    await _notificationService.deleteNotification(notificationId);
    _notifications.removeWhere((notification) => notification.id == notificationId);
    notifyListeners();
  }
}
