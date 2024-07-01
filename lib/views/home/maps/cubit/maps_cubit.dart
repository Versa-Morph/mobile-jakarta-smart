import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_jakarta/cubit/location_cubit/location_cubit.dart';
import 'package:smart_jakarta/models/place_autocomplete.dart';
import 'package:smart_jakarta/services/apis_service.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  MapsCubit({required this.locationCubit}) : super(MapsState.initial());
  final LocationCubit locationCubit;
  final Completer<GoogleMapController> _mapsController = Completer();

  LocationState get locationState => locationCubit.state;

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

// Point user location
  Future<void> pointUserLocation() async {
    final currentState = locationState;
    if (currentState is LocationAcquired) {
      final userLocation = currentState.userLocation;

      final marker = Marker(
        markerId: const MarkerId('UserMark'),
        position: LatLng(userLocation.latitude, userLocation.longitude),
        infoWindow: const InfoWindow(title: 'Location'),
      );

      final newMarkers = List<Marker>.from(state.markers)..add(marker);

      emit(state.copyWith(markers: newMarkers));
    }
  }

  /// Go to user location
  Future<void> goToUserLocation() async {
    final currentState = locationState;
    if (currentState is LocationAcquired) {
      final userLocation = currentState.userLocation;
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
