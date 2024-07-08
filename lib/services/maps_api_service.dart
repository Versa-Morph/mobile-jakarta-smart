import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:smart_jakarta/constant/constant.dart' as constant;
import 'package:smart_jakarta/exception/exception.dart';
import 'package:smart_jakarta/models/directions.dart';
import 'package:smart_jakarta/models/nearby_places.dart';
import 'package:smart_jakarta/models/place_autocomplete.dart';
import 'package:smart_jakarta/models/place_details.dart';

class MapsApiService {
  /// Get direction to places from user location
  Future<Directions?> getDirection({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final url = Uri.parse(
      '${constant.MAPS_DIRECTIONS_URL}origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=${constant.MAPS_API_KEY}',
    );

    final response = await http.get(url, headers: {
      "X-Android-Package": "com.smartjkt.smart_jakarta",
      "X-Android-Cert": "ED7C244053751E346B05BD4C02C9E4DC876407C2",
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final resBody = jsonDecode(response.body) as Map<String, dynamic>;
      return Directions.fromMap(resBody);
    }
    return null;
  }

  /// Search places detail based on placeId from google maps
  Future<PlaceDetails?> placeLocation(String placesId) async {
    try {
      final url = Uri.parse(
        '${constant.PLACE_LOCATION_URL}$placesId?fields=displayName,location&key=${constant.MAPS_API_KEY}',
      );
      final response = await http.get(url, headers: {
        "X-Android-Package": "com.smartjkt.smart_jakarta",
        "X-Android-Cert": "ED7C244053751E346B05BD4C02C9E4DC876407C2",
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body) as Map<String, dynamic>;
        return PlaceDetails.fromJson(resBody);
      }
    } catch (e) {
      throw BaseException(e.toString());
    }
    return null;
  }

  /// Autocomplete places on searchbar
  Future<PlacesAutocomplete?> placesAutocomplete(String? query) async {
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
        return placesAutocompleteFromJson(response.body);
      }
    } catch (e) {
      throw BaseException(e.toString());
    }
    return null;
  }

  /// Search nearby police and fire station within 2000 radius of user location
  Future<NearbyPlaces?> placesNearby(Position? currentPosition) async {
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
        return nearbyPlacesFromJson(response.body);
      }
    } catch (e) {
      throw BaseException(e.toString());
    }
    return null;
  }
}
