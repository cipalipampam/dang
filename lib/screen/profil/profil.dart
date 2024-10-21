import 'dart:io';
import 'package:damping/screen/profil/component/helpcenter.dart';
import 'package:damping/screen/profil/component/myaccount.dart';
import 'package:damping/screen/profil/component/mystore.dart';
import 'package:damping/screen/profil/component/profilmenu.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _imagePath = ""; // Path to user image

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.photo_library),
                            title: const Text('Choose from gallery'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.gallery);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.camera_alt),
                            title: const Text('Take a photo'),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.camera);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imagePath.isNotEmpty
                    ? FileImage(
                        File(_imagePath)) // Use FileImage to display the image
                    : null,
                backgroundColor: Colors.orange, // Background color for avatar
                child: _imagePath.isEmpty
                    ? const Icon(Icons.add_a_photo, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: Icons.account_circle,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyAccountScreen()),
                );
              },
            ),
            ProfileMenu(
              text: "My Store",
              icon: Icons.store,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyStoreScreen()),
                );
              },
            ),
            ProfileMenu(
              text: "Help Center",
              icon: Icons.help,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HelpCenterScreen()),
                );
              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: Icons.logout,
              press: () {
                // Fungsi logout dinonaktifkan sementara
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logout button pressed')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
