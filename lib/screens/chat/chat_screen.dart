import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  final String userId;
  final String receiverId;

  ChatScreen({required this.userId, required this.receiverId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  IO.Socket? socket;
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _initializeSocket();
  }

  void _initializeSocket() {
    socket = IO.io('http://localhost:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket?.connect();

    socket?.on('connect', (_) {
      print('Connected to server');
      // Register the user with the socket
      socket?.emit('register', widget.userId);
    });

    socket?.on('receiveMessage', (data) {
      if (data != null && data is Map<String, dynamic>) {
        setState(() {
          _messages.add(Map<String, dynamic>.from(data));
        });
      } else {
        print('Received data is not in expected format: $data');
      }
    });

    socket?.on('disconnect', (_) {
      print('Disconnected from server');
    });

    socket?.onError((error) {
      print('Socket error: $error');
    });
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final message = {
        'senderId': widget.userId,
        'receiverId': widget.receiverId,
        'message': _controller.text,
      };
      socket?.emit('privateMessage', message);
      setState(() {
        _messages.add(message);
      });
      _controller.clear();
    }
  }

  @override
  void dispose() {
    socket?.disconnect();
    socket?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.receiverId}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                reverse: true, // Display the latest messages at the bottom
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final messageText = message['message'] ?? 'No message';
                  final senderId = message['senderId'] ?? 'Unknown';

                  return ListTile(
                    title: Text(messageText),
                    subtitle: Text(
                      senderId == widget.userId ? 'You' : 'Other',
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                  );
                },
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Send a message',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
