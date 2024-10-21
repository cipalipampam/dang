import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FormProdukScreen extends StatefulWidget {
  static String routeName = "/form-produk";

  @override
  _FormProdukScreenState createState() => _FormProdukScreenState();
}

class _FormProdukScreenState extends State<FormProdukScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _selectedImage; // Variabel untuk menyimpan file gambar

  Future<void> _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null)
      return; // Jika tidak ada gambar yang dipilih, langsung return

    setState(() {
      _selectedImage = File(returnedImage.path); // Set gambar yang dipilih
    });
  }

  Future<void> _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null)
      return; // Jika tidak ada gambar yang dipilih, langsung return

    setState(() {
      _selectedImage = File(returnedImage.path); // Set gambar yang dipilih
    });
  }

  void _sendMessage() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final description = _descriptionController.text;
      final price = _priceController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Produk $name berhasil ditambahkan!'),
        ),
      );

      // Reset form dan gambar
      _nameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      setState(() {
        _selectedImage = null; // Reset gambar yang dipilih
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Produk"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextFieldCard(
                  label: "Nama Produk",
                  controller: _nameController,
                  maxLength: 255,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nama produk tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2),
                _buildTextFieldCard(
                  label: "Deskripsi Produk",
                  controller: _descriptionController,
                  maxLines: 3,
                  maxLength: 3000,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Deskripsi produk tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2),
                _buildTextFieldCard(
                  label: "Harga Produk",
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harga produk tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2),
                _buildImagePickerCard(),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: Text("Simpan Produk"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePickerCard() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pilih Gambar Produk",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _selectedImage != null
                        ? _selectedImage!.path.split('/').last
                        : "Ambil gambar dari galeri atau kamera",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () => _pickImageFromCamera(), // Ambil dari kamera
                ),
                IconButton(
                  icon: Icon(Icons.photo_library),
                  onPressed: () => _pickImageFromGallery(), // Ambil dari galeri
                ),
              ],
            ),
            SizedBox(height: 10),
            // Jika gambar telah dipilih, tampilkan gambar
            if (_selectedImage != null)
              Image.file(
                _selectedImage!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              )
            else
              Text(
                "Gambar belum dipilih",
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldCard({
    required String label,
    required TextEditingController controller,
    int? maxLines,
    int? maxLength,
    TextInputType? keyboardType,
    FormFieldValidator<String>? validator,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                counterText: '',
              ),
              maxLines: maxLines,
              keyboardType: keyboardType,
              maxLength: maxLength,
              validator: validator,
            ),
          ],
        ),
      ),
    );
  }
}
