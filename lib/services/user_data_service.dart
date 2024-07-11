import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:smart_jakarta/exception/exception.dart';
import 'package:smart_jakarta/models/user_bio.dart';
import 'package:smart_jakarta/models/user_contact.dart';
import 'package:smart_jakarta/network/api.dart';

class UserDataService {
  final Network _network = Network();

  Future<UserBio?> fetchUserBio() async {
    try {
      final response = await _network.getData('/user-bio');

      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);
        final userData = resBody['data'] as Map<String, dynamic>;

        return UserBio.fromJson(userData);
      }
    } on TimeoutException catch (_) {
      throw ReqTimeoutException(
          'Error Connecting to Server, Request Timed Out');
    } on ClientException catch (_) {
      throw AuthException('Error Connecting to Server');
    } catch (e) {
      throw AuthException(e.toString());
    }
    return null;
  }

  Future<List<UserContact>?> fetchUserContact() async {
    try {
      final response = await _network.getData('/user-contacts');

      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);
        final data = resBody['data'] as List;

        final contactList =
            data.map((json) => UserContact.fromJson(json)).toList();

        return contactList;
      }
    } on TimeoutException catch (_) {
      throw ReqTimeoutException(
          'Error Connecting to Server, Request Timed Out');
    } on ClientException catch (_) {
      throw AuthException('Error Connecting to Server');
    } catch (e) {
      throw AuthException(e.toString());
    }
    return null;
  }
}
