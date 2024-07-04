import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:smart_jakarta/exception/exception.dart';

class LocationService {
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    // Check if the gps is on or of
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    // Asking user for the permission
    await Geolocator.requestPermission();
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      return false;
    }
    if (locationPermission == LocationPermission.deniedForever) {
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
    } on TimeoutException catch (_) {
      throw TimeoutException('Request Timed Out');
    } on LocationServiceDisabledException catch (_) {
      throw BaseException('GPS Service Disabled');
    } catch (e) {
      throw BaseException('Somethings Wrong, Please Reload The App');
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
    } on TimeoutException catch (_) {
      throw TimeoutException('Request Timed Out');
    } on LocationServiceDisabledException catch (_) {
      throw BaseException('GPS Service Disabled');
    } catch (e) {
      throw BaseException('Somethings Wrong, Please Reload The App');
    }
  }
}
