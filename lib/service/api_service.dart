import 'dart:convert';
import 'dart:io'; // Pastikan untuk mengimpor ini
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://953e-36-85-52-5.ngrok-free.app/api';

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/sign_in');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          print("Login successful");
          return true; // Login berhasil
        } else {
          print("Login failed: ${data['error']}");
          return false; // Login gagal
        }
      } else {
        print("Server error: ${response.statusCode}");
        return false; // Kesalahan server
      }
    } catch (e) {
      print("Error: $e");
      return false; // Gagal karena exception
    }
  }

  Future<bool> register(
      String name, String email, String password, File? foto) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/sign_up'));

      // Menambahkan field untuk nama, email, dan password
      request.fields['nama'] = name;
      request.fields['email'] = email;
      request.fields['password'] = password;

      // Jika foto dipilih, tambahkan ke permintaan
      if (foto != null) {
        request.files.add(await http.MultipartFile.fromPath('foto', foto.path));
      }

      // Menambahkan header jika perlu
      request.headers["Content-Type"] = "multipart/form-data";

      // Mengirim permintaan dan menunggu respons
      var response = await request.send();

      // Memeriksa status kode
      if (response.statusCode == 201) {
        // Mendapatkan data dari respons
        final responseData = await http.Response.fromStream(response);
        final data = jsonDecode(responseData.body);
        if (data['success']) {
          print("Registration successful");
          return true; // Registrasi berhasil
        } else {
          print("Registration failed: ${data['error']}");
          return false; // Registrasi gagal
        }
      } else {
        print("Server error: ${response.statusCode}");
        return false; // Kesalahan server
      }
    } catch (e) {
      print("Error: $e");
      return false; // Gagal karena exception
    }
  }

  Future<bool> forgotPassword(String email) async {
    final url =
        Uri.parse('$baseUrl/forgot_password'); // Pastikan endpoint sesuai

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          print("Password reset link sent successfully");
          return true; // Pengiriman link reset berhasil
        } else {
          print("Failed to send reset link: ${data['error']}");
          return false; // Pengiriman link reset gagal
        }
      } else {
        print("Server error: ${response.statusCode}");
        return false; // Kesalahan server
      }
    } catch (e) {
      print("Error: $e");
      return false; // Gagal karena exception
    }
  }
}
