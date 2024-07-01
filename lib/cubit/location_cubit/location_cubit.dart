import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_jakarta/services/location_service.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(const LocationState());

  // Get user location
  Future<void> getUserLocation() async {
    LocationService locationService = LocationService();

    final userLocation = await locationService.getCurrentPosition();
    emit(state.copyWith(userPosition: userLocation));
  }
}
