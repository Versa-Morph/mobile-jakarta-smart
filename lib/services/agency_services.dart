import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:smart_jakarta/exception/exception.dart';
import 'package:smart_jakarta/models/agency.dart';
import 'package:smart_jakarta/network/api.dart';

class AgencyServices {
  final Network _network = Network();

  Future<List<Agency>?> fetchAgencyData() async {
    try {
      final response = await _network.getData('/instances/group-by-detail');

      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);
        final data = resBody['data'] as List;

        final agencyList = data.map((json) => Agency.fromJson(json)).toList();
        return agencyList;
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
