import 'package:flutter/material.dart';

class MyStoreScreen extends StatelessWidget {
  const MyStoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Store'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome to My Store!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Tambahkan fungsi untuk melakukan sesuatu, misalnya pergi ke halaman manajemen produk
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Manage products pressed')),
                  );
                },
                child: const Text('Manage Products'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
