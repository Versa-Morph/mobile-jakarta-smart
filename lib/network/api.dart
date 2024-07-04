import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_jakarta/local_env.dart';

class Network {
  String? token;

  void storeToken(String token, int expiresIn) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    int currentTime = DateTime.now().millisecondsSinceEpoch ~/
        1000; // Current time in seconds
    int expirationTime = currentTime + expiresIn; // Expiration time in seconds
    localStorage.setString(
        'token',
        jsonEncode({
          'token': token,
          'expires_in': expirationTime,
        }));
  }

  Future<void> _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // Mengambil string JSON dari local storage
    String? jsonString = localStorage.getString('token');

    if (jsonString != null) {
      Map<String, dynamic> jsonData = jsonDecode(jsonString);

      // Mengambil nilai token
      token = jsonData['data']['access_token']['token'];
      print(token);
    } else {
      print("Token not found in local storage.");
    }
  }

  Future<http.Response> auth(Map<String, String> data, String endPoint) async {
    final fullUrl = '$API_URL$endPoint';
    return await http
        .post(
          Uri.parse(fullUrl),
          body: jsonEncode(data),
          headers: _setHeaders(),
        )
        .timeout(const Duration(seconds: 10));
  }

  Future<http.Response> getData(String endPoint) async {
    final fullUrl = '$API_URL$endPoint';
    await _getToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  Map<String, String> _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
