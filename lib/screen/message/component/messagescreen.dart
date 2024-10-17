import 'dart:io'; // Import untuk File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MessageScreen extends StatefulWidget {
  final String chatName;
  final String avatarUrl;

  const MessageScreen({
    Key? key,
    required this.chatName,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _messages = []; // Menyimpan pesan dan gambar

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        // Menambahkan gambar ke pesan
        _messages.add({'image': File(pickedFile.path)});
      });
      _scrollToBottom();
    }
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        // Menambahkan pesan teks ke daftar pesan
        _messages.add({'text': _messageController.text});
        _messageController.clear();
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _showFullImage(File image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullImageScreen(image: image),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.avatarUrl),
            ),
            const SizedBox(width: 10),
            Text(widget.chatName),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo),
            onPressed: () => _pickImage(ImageSource.gallery),
          ),
          IconButton(
            icon: const Icon(Icons.camera),
            onPressed: () => _pickImage(ImageSource.camera),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (message['text'] != null) ...[
                            Text(
                              message['text'],
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                            const SizedBox(height: 5),
                          ],
                          if (message['image'] != null) ...[
                            GestureDetector(
                              onTap: () => _showFullImage(message['image']),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  message['image'],
                                  width: 200, // Lebar gambar
                                  height: 200, // Tinggi gambar
                                  fit: BoxFit
                                      .cover, // Mengatur agar gambar memenuhi kontainer
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                          ],
                          Text(
                            '14:58', // Ganti dengan waktu dinamis jika perlu
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FullImageScreen extends StatelessWidget {
  final File image;

  const FullImageScreen({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Center(
        child: Image.file(image),
      ),
    );
  }
}
