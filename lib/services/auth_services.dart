import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_jakarta/exception/auth_exception.dart';
import 'package:smart_jakarta/network/api.dart';

class AuthServices {
  /// Login with email and password
  static Future<bool> login(String email, String password) async {
    try {
      final response = await Network().auth(
        {
          'email': email,
          'password': password,
        },
        '/login',
      );

      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);
        final token = resBody['data']['access_token']['token'];
        final expiresIn = resBody['data']['access_token']['expires_in'];

        Network.storeToken(token, expiresIn);

        return true;
      }
    } catch (e) {
      // TODO: IMPLEMENT EXCEPTION
      throw AuthException(e.toString());
    }
    return false;
  }

  /// Register with username, email and password
  static Future<bool> register(
    String username,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      final response = await Network().auth(
        {
          'name': username,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        },
        '/register',
      );
      final resBody = jsonDecode(response.body);

      if (resBody['success']) {
        final token = resBody['data']['access_token']['token'];
        final expiresIn = resBody['data']['access_token']['expires_in'];

        Network.storeToken(token, expiresIn);

        return true;
      } else if (resBody['data']['email'] != null) {
        throw AuthException(resBody['data']['email'][0].toString());
      } else if (resBody['data']['password'] != null) {
        throw AuthException(resBody['data']['password'][0].toString());
      }
    } catch (e) {
      throw AuthException(e.toString());
    }

    return false;
  }

  /// Check token from local storage
  /// if token exist mean user is authenticated
  /// checking the expiration time
  static Future<bool> isAuthenticated() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? tokenString = localStorage.getString('token');

    if (tokenString != null) {
      final Map<String, dynamic> tokenData = jsonDecode(tokenString);
      int expirationTime = tokenData['expires_in'];
      int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      if (currentTime < expirationTime) {
        return true;
      } else {
        await logout(); // Remove Expired Token
      }
    }
    return false;
  }

  /// Log user out, remove token from local storage
  static Future<void> logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.remove('token');
  }
}
