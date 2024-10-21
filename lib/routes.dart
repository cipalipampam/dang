import 'package:damping/navigation.dart';
import 'package:damping/screen/home/homescreen.dart';
import 'package:damping/screen/message/message.dart';
import 'package:damping/screen/profil/profil.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
// import 'dart:io';
// ignore: unused_import
import 'dart:js';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  Navigation.routeName: (context) => const Navigation(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  Message.routename: (context) => const Message(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
};

// Optional: Uncomment this if you need to handle dynamic routes
// Route<dynamic>? onGenerateRoute(RouteSettings settings) {
//   // Implement any dynamic routes here if needed
//   return null;
// }
