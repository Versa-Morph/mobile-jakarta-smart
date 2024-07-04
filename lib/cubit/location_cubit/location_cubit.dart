import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_jakarta/services/location_service.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(const LocationState());

  final _locationService = LocationService();

  Future<Position?> _fetchUserLocation() async {
    try {
      final userLocation = await _locationService.getCurrentPosition();
      if (userLocation != null) {
        return userLocation;
      }
    } catch (e) {
      emit(LocationError(e.toString()));
    }
    return null;
  }

  Future<void> getUserLocation() async {
    emit(LocationLoading());
    final userLocation = await _fetchUserLocation();
    if (userLocation != null) {
      final listPlacemark = await placemarkFromCoordinates(
        userLocation.latitude,
        userLocation.longitude,
      );
      emit(LocationAcquired(userLocation, listPlacemark));
    }
  }
}
