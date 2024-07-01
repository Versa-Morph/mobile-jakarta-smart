part of 'location_cubit.dart';

class LocationState extends Equatable {
  const LocationState({
    this.userPosition,
  });
  final Position? userPosition;

  @override
  List<Object?> get props => [userPosition];

  LocationState copyWith({Position? userPosition}) {
    return LocationState(userPosition: userPosition ?? this.userPosition);
  }
}
