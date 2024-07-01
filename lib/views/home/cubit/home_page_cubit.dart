import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_jakarta/cubit/location_cubit/location_cubit.dart';
import 'package:smart_jakarta/models/nearby_places.dart';
import 'package:smart_jakarta/models/place_autocomplete.dart';
import 'package:smart_jakarta/services/api_service.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit({required this.locationCubit}) : super(HomePageState.initial());
  final LocationCubit locationCubit;
  LocationState get locationState => locationCubit.state;

  final PageController pageController = PageController();
  final Completer<GoogleMapController> _mapsController = Completer();

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

  void clear() {
    emit(state.copyWith(
      markers: [],
      placesSuggestions: [],
    ));
  }

  /// Set googlemaps controller
  void setController(GoogleMapController controller) {
    _mapsController.complete(controller);
  }

  /// Navigating the page
  void changeTab(int tabIndex) {
    emit(state.copyWith(tabIndex: tabIndex));
  }
}
