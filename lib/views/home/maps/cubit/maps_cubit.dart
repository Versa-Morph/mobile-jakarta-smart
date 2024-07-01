import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_jakarta/cubit/location_cubit/location_cubit.dart';
import 'package:smart_jakarta/models/nearby_places.dart';
import 'package:smart_jakarta/models/place_autocomplete.dart';
import 'package:smart_jakarta/services/api_service.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  MapsCubit({required this.locationCubit}) : super(MapsState.initial());
  final LocationCubit locationCubit;
  final Completer<GoogleMapController> _mapsController = Completer();

  LocationState get locationState => locationCubit.state;

  /// Search Police Station and Fire Station Nearby
  Future<void> nearbyPlaces() async {
    final currentState = locationState;
    if (currentState is LocationAcquired) {
      final List<Marker> markerList = [
        Marker(
          markerId: const MarkerId('UserMark'),
          position: LatLng(
            currentState.userLocation.latitude,
            currentState.userLocation.longitude,
          ),
          infoWindow: const InfoWindow(title: 'Location'),
        ),
      ];
      final userLocation = currentState.userLocation;
      final response = await ApiService.placesNearby(userLocation);

      if (response.statusCode == 200) {
        final result = nearbyPlacesFromJson(response.body);
        if (result.places != null) {
          for (Place place in result.places!) {
            if (place.location != null) {
              markerList.add(
                Marker(
                  markerId: MarkerId(place.displayName!.text!),
                  position: LatLng(
                    place.location!.latitude!,
                    place.location!.longitude!,
                  ),
                  infoWindow: InfoWindow(title: place.displayName!.text!),
                ),
              );

              emit(state.copyWith(markers: markerList));
            }
          }
        }
      }
    }
  }

  /// Autocomplete search places
  Future<void> searchPlacesAutoComplete(String? query) async {
    final response = await ApiService.placesAutocomplete(query);
    if (response.statusCode == 200) {
      final result = placesAutocompleteFromJson(response.body);
      emit(state.copyWith(
        placesSuggestions: result.suggestions,
        isSearchResultVisible: true,
      ));
    } else {
      emit(state.copyWith(
        placesSuggestions: [],
        isSearchResultVisible: false,
      ));
    }
  }

  /// Go to user location
  Future<void> goToUserLocation() async {
    final currentState = locationState;
    if (currentState is LocationAcquired) {
      final userLocation = currentState.userLocation;
      final cameraPosition = CameraPosition(
        target: LatLng(userLocation.latitude, userLocation.longitude),
        zoom: 15,
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
