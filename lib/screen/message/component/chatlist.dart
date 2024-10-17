import 'package:damping/screen/message/component/messagescreen.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  static String routeName = "/chatList";

  const ChatListScreen({Key? key}) : super(key: key);

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final List<Map<String, String>> _chats = [
    {
      'name': 'metwireofficial',
      'message': 'Itu kak',
      'date': '16/07',
      'status': 'Dibatasi',
      'avatar': 'https://via.placeholder.com/50',
    },
    {
      'name': 'zebrakencana',
      'message': 'Halo Kak, kami sungguh...',
      'date': '15/06',
      'avatar': 'https://via.placeholder.com/50',
    },
    // Add more chat data...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Cari',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(_chats[index]['avatar']!),
                  ),
                  title: Text(_chats[index]['name']!),
                  subtitle: Text(_chats[index]['message']!),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(_chats[index]['date']!),
                      if (_chats[index]['status'] != null)
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            _chats[index]['status']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessageScreen(
                          chatName: _chats[index]['name']!,
                          avatarUrl: _chats[index]['avatar']!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
