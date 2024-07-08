import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:smart_jakarta/constant/constant.dart' as constant;
import 'package:smart_jakarta/exception/exception.dart';

class MapsApiService {
  /// Search places detail based on placeId from google maps
  Future<http.Response?> placeLocation(String placesId) async {
    try {
      final url = Uri.parse(
        '${constant.PLACE_LOCATION_URL}$placesId?fields=location&key=${constant.MAPS_API_KEY}',
      );
      final response = await http.get(url, headers: {
        "X-Android-Package": "com.smartjkt.smart_jakarta",
        "X-Android-Cert": "ED7C244053751E346B05BD4C02C9E4DC876407C2",
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      throw BaseException(e.toString());
    }
    return null;
  }

  /// Autocomplete places on searchbar
  Future<http.Response?> placesAutocomplete(String? query) async {
    try {
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
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      throw BaseException(e.toString());
    }
    return null;
  }

  /// Search nearby police and fire station within 2000 radius of user location
  Future<http.Response?> placesNearby(Position? currentPosition) async {
    final url = Uri.parse('${constant.PLACES_URL}searchNearby');

    try {
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

      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      throw BaseException(e.toString());
    }
    return null;
  }
}
