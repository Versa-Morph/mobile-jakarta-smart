part of 'maps_cubit.dart';

class MapsState extends Equatable {
  const MapsState({
    required this.markers,
    required this.placesSuggestions,
    required this.isSearchResultVisible,
    required this.initialPosition,
  });

  final List<Marker> markers;
  final List<Suggestion> placesSuggestions;
  final bool isSearchResultVisible;
  final CameraPosition initialPosition;

  @override
  List<Object> get props => [
        markers,
        placesSuggestions,
        isSearchResultVisible,
        initialPosition,
      ];

  MapsState copyWith(
      {List<Marker>? markers,
      List<Suggestion>? placesSuggestions,
      bool? isSearchResultVisible,
      CameraPosition? initialPosition}) {
    return MapsState(
      markers: markers ?? this.markers,
      placesSuggestions: placesSuggestions ?? this.placesSuggestions,
      isSearchResultVisible:
          isSearchResultVisible ?? this.isSearchResultVisible,
      initialPosition: initialPosition ?? this.initialPosition,
    );
  }
}
