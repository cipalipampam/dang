import 'package:damping/navigation.dart';
import 'package:damping/screen/home/homescreen.dart';
import 'package:damping/screen/message/message.dart';
import 'package:damping/screen/profil/profil.dart';
import 'package:flutter/material.dart';
import 'package:damping/screen/splash/splash_screen.dart';
import 'package:damping/screen/sign_in/sign_in_screen.dart';
import 'package:damping/screen/sign_up/sign_up_screen.dart';
import 'package:damping/screen/forgot_password/forgot_password_screen.dart';
import 'package:damping/screen/produkAdmin/FormProdukScreen.dart';
// ignore: unused_import
import 'dart:js';

// We use name route

final Map<String, WidgetBuilder> routes = {
  FormProdukScreen.routeName: (context) => FormProdukScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
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
