import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notification_provider.dart';

class NotificationsScreen extends StatelessWidget {
  final String userId;

  NotificationsScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: FutureBuilder(
        future: Provider.of<NotificationProvider>(context, listen: false)
            .fetchNotifications(userId),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Consumer<NotificationProvider>(
              builder: (ctx, notificationProvider, _) => ListView.builder(
                itemCount: notificationProvider.notifications.length,
                itemBuilder: (ctx, index) {
                  final notification = notificationProvider.notifications[index];
                  return ListTile(
                    title: Text(notification.message),
                    subtitle: Text(notification.createdAt.toIso8601String()),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        notificationProvider.deleteNotification(notification.id);
                      },
                    ),
                    onTap: () {
                      notificationProvider.markAsRead(notification.id);
                    },
                    tileColor: notification.read ? Colors.grey[200] : Colors.white,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
