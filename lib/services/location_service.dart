import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationService {
  static Function(bool) locationPermissionHandler = (permission) {};

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    // Check if the gps is on or of
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationPermissionHandler(false);
      return false;
    }

    // Asking user for the permission
    await Geolocator.requestPermission();
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermissionHandler(false);
      return false;
    }
    if (locationPermission == LocationPermission.deniedForever) {
      locationPermissionHandler(false);
      return false;
    }

    return true;
  }

  Future<Position?> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      return null;
    }

    try {
      final Position userPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return userPosition;
    } on TimeoutException catch (e) {
      // TODO: IMPLEMENT EXCEPTION
      print(e.message);
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Stream<Position>?> streamUserLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      return null;
    }
    try {
      final userPosition = Geolocator.getPositionStream();
      return userPosition;
    } catch (e) {
      // TODO: IMPLEMENT EXCEPTION
      print(e);
      return null;
    }
  }
}
