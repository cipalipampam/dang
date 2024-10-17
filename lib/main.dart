import 'package:damping/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Project', // Berikan judul untuk aplikasi
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
      routes: routes, // Mengatur rute dari file routes.dart
    );
  }
}
