import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_jakarta/exception/exception.dart';
import 'package:smart_jakarta/network/api.dart';

class AuthServices {
  final Network _network = Network();

  /// Login with email and password
  Future<bool> login(String email, String password) async {
    try {
      final response = await _network.auth(
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

        _network.storeToken(token, expiresIn);

        return true;
      }
    } on TimeoutException catch (_) {
      throw AuthException('Error Connecting to Server, Request Timed Out');
    } on ClientException catch (_) {
      throw AuthException('Error Connecting to Server');
    } catch (e) {
      throw AuthException(e.toString());
    }
    return false;
  }

  /// Register with username, email and password
  Future<bool> register(
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

        _network.storeToken(token, expiresIn);

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
  Future<bool> isAuthenticated() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? tokenString = localStorage.getString('token');

    if (tokenString != null) {
      return true;
    }
    return false;
  }

  /// Log user out, remove token from local storage
  Future<void> logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.remove('token');
  }
}
