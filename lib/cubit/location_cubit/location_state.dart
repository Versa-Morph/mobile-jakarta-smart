part of 'location_cubit.dart';

class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationAcquired extends LocationState {
  const LocationAcquired(this.userLocation, this.placemarks);
  final Position userLocation;
  final List<Placemark> placemarks;

  @override
  List<Object?> get props => [userLocation, placemarks];
}

class LocationLoading extends LocationState {}

class LocationError extends LocationState {
  const LocationError(this.errorMsg);
  final String errorMsg;
  @override
  List<Object?> get props => [errorMsg];
}
