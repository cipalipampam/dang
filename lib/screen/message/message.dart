import 'package:damping/screen/message/component/chatlist.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  static String routename = '/message';
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DangLing Chat'),
      ),
      body: ChatListScreen(), // Tampilkan ChatListScreen sebagai konten utama
    );
  }
}
