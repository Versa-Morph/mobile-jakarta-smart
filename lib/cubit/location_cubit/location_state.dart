part of 'location_cubit.dart';

class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];

  // LocationState copyWith({Position? userPosition}) {
  //   return LocationState(userPosition: userPosition ?? this.userPosition);
  // }
}

class LocationAcquired extends LocationState {
  const LocationAcquired(this.userLocation);
  final Position userLocation;

  @override
  List<Object?> get props => [userLocation];
}

class LocationLoading extends LocationState {
  const LocationLoading();
  @override
  List<Object?> get props => [];
}
