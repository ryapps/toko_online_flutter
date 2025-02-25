import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_shop_app/models/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_shop_app/models/response_data_map.dart';
import 'package:online_shop_app/services/url.dart' as url;

class UserService {
  Future<ResponseDataMap> registerUser(Map<String, dynamic> data) async {
    var uri = Uri.parse("${url.BaseUrl}register");
    var response = await http.post(uri, body: data);

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      if (responseData["status"] == 'success') {
        return ResponseDataMap(
            status: true, message: "Sukses menambah user", data: responseData);
      } else {
        var message = '';
        responseData["message"].forEach((key, value) {
          message += value[0].toString() + '\n';
        });
        return ResponseDataMap(status: false, message: message);
      }
    } else {
      return ResponseDataMap(
          status: false,
          message:
              "Gagal menambah user dengan kode error ${response.statusCode}");
    }
  }

 
  Future loginUser(data) async {
    var uri = Uri.parse(url.BaseUrl + "login");
    var response = await http.post(uri, body: data);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data["status"] == true) {
        UserLogin userLogin = UserLogin(
            status: data["status"],
            token: data["authorisation"]["token"],
            message: data["message"],
            id: data["data"]["id"],
            nama_user: data["data"]["name"],
            email: data["data"]["email"],
            role: data["data"]["role"]);
        await userLogin.prefs();
        ResponseDataMap response = ResponseDataMap(
            status: true, message: "Sukses login user", data: data);
        return response;
      } else {
        ResponseDataMap response =
            ResponseDataMap(status: false, message: 'Email dan password salah');
        return response;
      }
    } else {
      ResponseDataMap response = ResponseDataMap(
          status: false,
          message:
              "gagal menambah user dengan code error ${data.statusCode}");
      return response;
    }
  }


  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Hapus semua data sesi pengguna
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // Ambil token pengguna
  }

  Future<ResponseDataMap> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Ambil token dari session

    if (token == null) {
      return ResponseDataMap(status: false, message: "Token tidak ditemukan");
    }

    final uri = Uri.parse('${url.BaseUrl}logout'); // API Logout (GET request)

    try {
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await prefs.clear(); // Hapus sesi setelah logout berhasil
        return ResponseDataMap(status: true, message: "Logout berhasil");
      } else {
        var message = jsonDecode(response.body)['message'] ?? 'Logout gagal';
        return ResponseDataMap(status: false, message: message);
      }
    } catch (e) {
      return ResponseDataMap(
          status: false, message: "Terjadi kesalahan saat logout");
    }
  }
}
