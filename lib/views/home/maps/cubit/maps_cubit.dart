import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_jakarta/cubit/location_cubit/location_cubit.dart';
import 'package:smart_jakarta/models/location.dart';
import 'package:smart_jakarta/models/nearby_places.dart';
import 'package:smart_jakarta/models/place_autocomplete.dart';
import 'package:smart_jakarta/services/maps_api_service.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  MapsCubit({required this.locationCubit}) : super(MapsState.initial());
  final LocationCubit locationCubit;
  LocationState get locationState => locationCubit.state;

  /// controller for google maps
  final Completer<GoogleMapController> _mapsController = Completer();

  /// Instance of Maps API Service
  final MapsApiService _mapsApiService = MapsApiService();

  /// Instance of focus node for search bar in maps page
  final FocusNode focusNode = FocusNode();

  /// method to unfocus the search bar
  void unfocusSearchBar() {
    focusNode.unfocus();
  }

  void clearMsg() {
    emit(state.copyWith(errorMsg: ''));
  }

  /// Set googlemaps controller
  void setController(GoogleMapController controller) {
    _mapsController.complete(controller);
  }

  /// Place marker to map from place id when user search places
  Future<void> markPlaces(String placesId) async {
    emit(state.copyWith(markers: []));

    try {
      final response = await _mapsApiService.placeLocation(placesId);
      if (response != null) {
        final result = jsonDecode(response.body);
        final data = result['location'];
        final Location location = Location.fromJson(data);

        // add marker
        final markers = [
          Marker(
            markerId: const MarkerId('newPlaces'),
            position: LatLng(location.latitude!, location.longitude!),
            infoWindow: InfoWindow.noText,
          )
        ];
        // Unfocus the searchbar
        unfocusSearchBar();
        emit(state.copyWith(
          markers: markers,
          isSearchResultVisible: false,
        ));

        // add camera position
        final cameraPosition = CameraPosition(
          target: LatLng(location.latitude!, location.longitude!),
          zoom: 15,
        );

        // animate to marker
        final GoogleMapController controller = await _mapsController.future;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      }
    } catch (e) {
      emit(state.copyWith(errorMsg: e.toString()));
    }
  }

  /// Autocomplete search places
  Future<void> searchPlacesAutoComplete(String? query) async {
    final response = await _mapsApiService.placesAutocomplete(query);

    if (response != null) {
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

  /// Search Police Station and Fire Station Nearby
  Future<void> nearbyPlaces() async {
    final currentState = locationState;
    if (currentState is LocationAcquired) {
      // Add marker for user location
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
      final response = await _mapsApiService.placesNearby(userLocation);

      if (response != null) {
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
        final cameraPosition = CameraPosition(
          target: LatLng(userLocation.latitude, userLocation.longitude),
          zoom: 15,
        );

        final GoogleMapController controller = await _mapsController.future;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      }
    }
  }
}
