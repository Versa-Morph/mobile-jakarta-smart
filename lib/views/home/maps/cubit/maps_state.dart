part of 'maps_cubit.dart';

class MapsState extends Equatable {
  const MapsState({
    required this.markers,
    required this.placesSuggestions,
    required this.isSearchResultVisible,
  });

  final List<Marker> markers;
  final List<Suggestion> placesSuggestions;
  final bool isSearchResultVisible;

  @override
  List<Object?> get props => [
        markers,
        placesSuggestions,
        isSearchResultVisible,
      ];

  MapsState copyWith({
    List<Marker>? markers,
    List<Suggestion>? placesSuggestions,
    bool? isSearchResultVisible,
    Position? userPosition,
  }) {
    return MapsState(
      markers: markers ?? this.markers,
      placesSuggestions: placesSuggestions ?? this.placesSuggestions,
      isSearchResultVisible:
          isSearchResultVisible ?? this.isSearchResultVisible,
    );
  }

  factory MapsState.initial() {
    return const MapsState(
      markers: [],
      placesSuggestions: [],
      isSearchResultVisible: false,
    );
  }
}
