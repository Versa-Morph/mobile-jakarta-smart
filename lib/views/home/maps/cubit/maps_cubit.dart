import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_jakarta/constant/constant.dart' as constant;
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_jakarta/models/place_autocomplete.dart';
import 'package:smart_jakarta/services/location_service.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  MapsCubit()
      : super(
          const MapsState(
            initialPosition: CameraPosition(
              target: LatLng(
                -6.203581902710393,
                107.00458244057064,
              ),
              zoom: 18,
            ),
            markers: [],
            placesSuggestions: [],
            isSearchResultVisible: false,
          ),
        );

  final Completer<GoogleMapController> _mapsController = Completer();

  /// Autocomplete search places
  Future<void> searchPlacesAutoComplete(String query) async {
    const url = 'https://places.googleapis.com/v1/places:autocomplete';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "X-Android-Package": "com.smartjkt.smart_jakarta",
        "X-Android-Cert": "ED7C244053751E346B05BD4C02C9E4DC876407C2",
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': constant.API_KEY,
      },
      body: jsonEncode(
        {
          "input": query,
        },
      ),
    );

    if (response.statusCode == 200) {
      final result = placesAutocompleteFromJson(response.body);

      if (result.suggestions != null) {
        emit(state.copyWith(
          placesSuggestions: result.suggestions,
          isSearchResultVisible: true,
        ));
      } else {
        emit(
          state.copyWith(
            placesSuggestions: [],
            isSearchResultVisible: false,
          ),
        );
      }
    }
  }

// Get user location
  Future<Position?> getUserLocation() async {
    LocationService locationService = LocationService();
    return await locationService.getCurrentPosition();
  }

// Point user location
  Future<void> pointUserLocation() async {
    final userLocation = await getUserLocation();
    if (userLocation != null) {
      final marker = Marker(
        markerId: const MarkerId('UserMark'),
        position: LatLng(userLocation.latitude, userLocation.longitude),
        infoWindow: const InfoWindow(title: 'Location'),
      );

      final newMarkers = List<Marker>.from(state.markers)..add(marker);

      final cameraPosition = CameraPosition(
        target: LatLng(userLocation.latitude, userLocation.longitude),
        zoom: 18,
      );

      final GoogleMapController controller = await _mapsController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      emit(state.copyWith(markers: newMarkers));
    }
  }

  /// Go to user location
  Future<void> goToUserLocation() async {
    final userLocation = await getUserLocation();
    if (userLocation != null) {
      final cameraPosition = CameraPosition(
        target: LatLng(userLocation.latitude, userLocation.longitude),
        zoom: 18,
      );

      final GoogleMapController controller = await _mapsController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  /// Set googlemaps controller
  void setController(GoogleMapController controller) {
    _mapsController.complete(controller);
  }
}
