import 'package:damping/screen/home/homescreen.dart';
import 'package:damping/screen/message/message.dart';
import 'package:damping/screen/profil/profil.dart';
import 'package:flutter/material.dart';

const Color inActiveIconColor = Color.fromARGB(255, 252, 59, 0);

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  static String routeName = "/navigation";

  @override
  State<Navigation> createState() => _InitScreenState();
}

class _InitScreenState extends State<Navigation> {
  int _selectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> pages = [
    const HomeScreen(),
    const Message(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar dapat diaktifkan jika diinginkan
      // appBar: AppBar(title: const Text('Dangling')),
      body: pages[
          _selectedIndex], // Menampilkan halaman sesuai dengan index yang dipilih
      bottomNavigationBar: NavigationBar(
        animationDuration: const Duration(seconds: 1),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          updateCurrentIndex(index);
        },
        destinations: _navBarItems,
      ),
    );
  }
}

const List<NavigationDestination> _navBarItems = [
  NavigationDestination(
    icon: Icon(Icons.home_outlined),
    selectedIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  NavigationDestination(
    icon: Icon(Icons.chat_bubble_outline),
    selectedIcon: Icon(Icons.chat_bubble),
    label: 'Chat',
  ),
  NavigationDestination(
    icon: Icon(Icons.person_outline_rounded),
    selectedIcon: Icon(Icons.person_rounded),
    label: 'Profile',
  ),
];
