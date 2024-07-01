import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_jakarta/services/location_service.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(const LocationState());

  Future<void> getUserLocation() async {
    emit(const LocationLoading());
    LocationService locationService = LocationService();
    final userLocation = await locationService.getCurrentPosition();
    if (userLocation != null) {
      emit(LocationAcquired(userLocation));
    }
  }
}
