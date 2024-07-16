import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_jakarta/exception/exception.dart';
import 'package:smart_jakarta/models/user_bio.dart';
import 'package:smart_jakarta/models/user_contact.dart';
import 'package:smart_jakarta/network/api.dart';

class UserDataService {
  final Network _network = Network();

  /// Fetch user bio from the server
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

  /// Fetch user contact from the server
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

  /// Store user bio to the server
  Future<bool> storeUserBio(
    String phoneNumber,
    String nik,
    XFile profilePict,
    String fullName,
    String nickname,
    String city,
    int age,
    String bloodtype,
    int height,
    int weight,
    String address,
  ) async {
    try {
      final response = await _network.store(
        {
          'phone_number': phoneNumber,
          'nik': nik,
          'full_name': fullName,
          'nickname': nickname,
          'city': city,
          'age': age.toString(),
          'blood_type': bloodtype,
          'height': height.toString(),
          'weight': weight.toString(),
          'address': address,
        },
        profilePict,
        '/user-bio',
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw BaseException(e.toString());
    }
    return false;
  }
}
