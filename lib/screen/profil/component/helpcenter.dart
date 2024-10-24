import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Help Center",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.orangeAccent, // Warna AppBar
        elevation: 4, // Memberikan bayangan pada AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // Aksi ketika tombol ikon ditekan
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Help Center Information",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Welcome to the Help Center. Here you can find answers to frequently asked questions and contact support for any issues.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Contoh daftar item bantuan
            ListTile(
              leading: const Icon(Icons.support_agent, color: Colors.orange),
              title: const Text("Contact Support"),
              subtitle: const Text("Get in touch with our support team."),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Aksi ketika item ditekan
              },
            ),
            ListTile(
              leading: const Icon(Icons.question_answer, color: Colors.orange),
              title: const Text("FAQs"),
              subtitle: const Text("Browse frequently asked questions."),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Aksi ketika item ditekan
              },
            ),
          ],
        ),
      ),
    );
  }
}
