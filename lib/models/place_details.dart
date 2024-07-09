import 'package:smart_jakarta/models/location.dart';
import 'package:smart_jakarta/models/place_display_name.dart';

class PlaceDetails {
  final PlaceDisplayName displayName;
  final String formattedAddress;
  final Location location;

  PlaceDetails({
    required this.displayName,
    required this.formattedAddress,
    required this.location,
  });

  factory PlaceDetails.fromJson(Map<String, dynamic> json) {
    return PlaceDetails(
      displayName: PlaceDisplayName.fromJson(json['displayName']),
      formattedAddress: json['formattedAddress'],
      location: Location.fromJson(json['location']),
    );
  }
}
