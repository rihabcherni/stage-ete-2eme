import 'package:flutter/material.dart';
import 'package:frontend/models/userMessage.dart';
import 'package:frontend/services/chat_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<UserMessage>> futureUsers;
  late String userId;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadUserId().then((_) {
      futureUsers = fetchUsers();
      setState(() {}); // Refresh the UI after loading the userId
    });
  }

  Future<void> _loadUserId() async {
    try {
      userId = await _storage.read(key: 'userId') ?? '';
      print('User ID loaded: $userId');
    } catch (error) {
      print('Error loading user ID: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: FutureBuilder<List<UserMessage>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                UserMessage user = snapshot.data![index];
                return ListTile(
                  leading: Image.network(
                    'http://127.0.0.1:5000${user.photo}',
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.role),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/chat',
                      arguments: {
                        'userId': userId,
                        'receiverId': user.userId,
                      },
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
