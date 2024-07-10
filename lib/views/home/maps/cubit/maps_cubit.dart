import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_jakarta/cubit/location_cubit/location_cubit.dart';
import 'package:smart_jakarta/models/directions.dart';
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

  /// Mark user location
  Future<void> markUserLocation() async {
    final currentState = locationState;
    if (currentState is LocationAcquired) {
      final userLocation = currentState.userLocation;
      final List<Marker> markers = [];
      markers.add(
        Marker(
          markerId: const MarkerId('0'),
          position: LatLng(userLocation.latitude, userLocation.longitude),
          onTap: () {
            emit(state.copyWith(markerIndex: 0));
          },
          infoWindow: const InfoWindow(
            title: 'MyLocation',
          ),
        ),
      );

      emit(state.copyWith(markers: markers));
    }
  }

  /// Place marker to map from place id when user search places
  Future<void> markPlaces(String placesId) async {
    // remove other markers except user marker
    if (state.markers.length > 1) {
      final markers = List<Marker>.from(state.markers)
        ..removeRange(1, state.markers.length);

      emit(
        state.copyWith(
          markers: markers,
          markerIndex: 0,
        ),
      );
    }
    try {
      final response = await _mapsApiService.placeLocation(placesId);
      if (response != null) {
        final displayName = response.displayName.text;
        final location = response.location;
        final formattedAddress = response.formattedAddress;

        final markers = state.markers;
        markers.add(
          Marker(
            markerId: const MarkerId('1'),
            position: LatLng(location.latitude!, location.longitude!),
            onTap: () {
              emit(state.copyWith(markerIndex: 1));
            },
            infoWindow:
                InfoWindow(title: displayName, snippet: formattedAddress),
          ),
        );
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
    final result = await _mapsApiService.placesAutocomplete(query);

    if (result != null) {
      final placeSuggestion = result.suggestions;
      emit(state.copyWith(
        placesSuggestions: placeSuggestion,
        isSearchResultVisible: true,
      ));
    } else {
      emit(state.copyWith(
        placesSuggestions: [],
        isSearchResultVisible: false,
      ));
    }
  }

  /// Search Police Station and Fire Station Nearby
  Future<void> nearbyPlaces() async {
    if (state.markers.length > 1) {
      final markers = List<Marker>.from(state.markers)
        ..removeRange(1, state.markers.length);

      emit(
        state.copyWith(
          markers: markers,
          markerIndex: 0,
        ),
      );
    }

    try {
      final currentState = locationState;

      if (currentState is LocationAcquired) {
        final userLocation = currentState.userLocation;
        final nearbyPlaces = await _mapsApiService.placesNearby(userLocation);

        final markerList = List<Marker>.from(state.markers);

        if (nearbyPlaces != null) {
          if (nearbyPlaces.places != null) {
            int i = 1;
            for (Place place in nearbyPlaces.places!) {
              if (place.location != null) {
                final index = i;
                markerList.add(
                  Marker(
                    markerId: MarkerId(index.toString()),
                    position: LatLng(
                      place.location!.latitude!,
                      place.location!.longitude!,
                    ),
                    onTap: () {
                      emit(state.copyWith(markerIndex: index));
                    },
                    infoWindow: InfoWindow(
                        title: place.displayName!.text!,
                        snippet: place.formattedAddress),
                  ),
                );

                i++;
              }
            }
          }
        }

        emit(state.copyWith(
          markers: markerList,
        ));

        final cameraPosition = CameraPosition(
          target: LatLng(userLocation.latitude, userLocation.longitude),
          zoom: 15,
        );

        final GoogleMapController controller = await _mapsController.future;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      }
    } catch (e) {
      emit(state.copyWith(errorMsg: e.toString()));
    }
  }

  Future<void> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    try {
      final directions = await _mapsApiService.getDirection(
        origin: origin,
        destination: destination,
      );

      if (directions != null) {
        emit(state.copyWith(directions: () => directions));
        final desCameraPosition = CameraPosition(
          target: LatLng(destination.latitude, destination.longitude),
          zoom: 15,
        );

        final GoogleMapController controller = await _mapsController.future;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(desCameraPosition));
      }
    } catch (e) {
      emit(state.copyWith(errorMsg: e.toString()));
    }
  }

  Future<void> clearDirections() async {
    final currentState = locationState;
    if (currentState is LocationAcquired) {
      final userLocation = currentState.userLocation;
      emit(state.copyWith(directions: () => null));
      final desCameraPosition = CameraPosition(
        target: LatLng(userLocation.latitude, userLocation.longitude),
        zoom: 18,
      );

      final GoogleMapController controller = await _mapsController.future;
      controller
          .animateCamera(CameraUpdate.newCameraPosition(desCameraPosition));
    }
  }
}
