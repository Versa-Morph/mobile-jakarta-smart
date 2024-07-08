import 'dart:convert';
import 'package:smart_jakarta/models/location.dart';
import 'package:smart_jakarta/models/place_display_name.dart';

NearbyPlaces nearbyPlacesFromJson(String responseBody) =>
    NearbyPlaces.fromJson(json.decode(responseBody));

class NearbyPlaces {
  final List<Place>? places;

  NearbyPlaces({
    this.places,
  });

  factory NearbyPlaces.fromJson(Map<String, dynamic> json) => NearbyPlaces(
        places: json["places"] == null
            ? []
            : List<Place>.from(json["places"]!.map((x) => Place.fromJson(x))),
      );
}

class Place {
  final String? formattedAddress;
  final Location? location;
  final PlaceDisplayName? displayName;

  Place({
    this.formattedAddress,
    this.location,
    this.displayName,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        formattedAddress: json["formattedAddress"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        displayName: json["displayName"] == null
            ? null
            : PlaceDisplayName.fromJson(json["displayName"]),
      );
}
