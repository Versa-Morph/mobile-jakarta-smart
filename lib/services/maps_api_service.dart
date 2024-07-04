import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:smart_jakarta/constant/constant.dart' as constant;

class MapsApiService {
  static Future<http.Response> placesAutocomplete(String? query) async {
    final url = Uri.parse('${constant.PLACES_URL}autocomplete');
    final response = await http.post(
      url,
      headers: {
        "X-Android-Package": "com.smartjkt.smart_jakarta",
        "X-Android-Cert": "ED7C244053751E346B05BD4C02C9E4DC876407C2",
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': constant.MAPS_API_KEY,
      },
      body: jsonEncode(
        {
          "input": query,
          "includedRegionCodes": ["id"],
        },
      ),
    );
    return response;
  }

  static Future<http.Response> placesNearby(Position? currentPosition) async {
    final url = Uri.parse('${constant.PLACES_URL}searchNearby');
    final response = await http.post(url,
        headers: {
          "X-Android-Package": "com.smartjkt.smart_jakarta",
          "X-Android-Cert": "ED7C244053751E346B05BD4C02C9E4DC876407C2",
          'Content-Type': 'application/json',
          'X-Goog-Api-Key': constant.MAPS_API_KEY,
          'X-Goog-FieldMask':
              'places.formattedAddress,places.displayName,places.location',
        },
        body: jsonEncode(
          {
            'includedPrimaryTypes': ['police', 'fire_station'],
            'locationRestriction': {
              'circle': {
                'center': {
                  'latitude': currentPosition!.latitude,
                  'longitude': currentPosition.longitude,
                },
                'radius': 2000,
              }
            }
          },
        ));
    return response;
  }
}
