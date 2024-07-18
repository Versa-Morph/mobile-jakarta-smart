import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_jakarta/exception/exception.dart';
import 'package:smart_jakarta/network/api.dart';

class IncidentServices {
  Future<bool> reportIncident({
    required String plusCode,
    required String description,
    required XFile incidentimage,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await Network().postWithImage(
        {
          'pluscode': plusCode,
          'description': description,
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
        },
        incidentimage,
        '/incidents',
        'image',
      );

      response.stream.transform(utf8.decoder).listen((value) {
        print('titoti $value');
      });

      if (response.statusCode == 200) {
        return true;
      }
    } on TimeoutException catch (_) {
      throw ReqTimeoutException(
          'Error Connecting to Server, Request Timed Out');
    } on ClientException catch (_) {
      throw AuthException('Error Connecting to Server');
    } catch (e) {
      throw BaseException(e.toString());
    }
    return false;
  }
}
