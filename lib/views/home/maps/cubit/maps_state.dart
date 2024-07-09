part of 'maps_cubit.dart';

class MapsState extends Equatable {
  const MapsState({
    required this.markers,
    required this.placesSuggestions,
    required this.isSearchResultVisible,
    required this.errorMsg,
    this.selectedMarkerIndex,
    this.directions,
  });

  final List<Marker> markers;
  final List<Suggestion> placesSuggestions;
  final bool isSearchResultVisible;
  final String errorMsg;
  final int? selectedMarkerIndex;
  final Directions? directions;

  @override
  List<Object?> get props => [
        markers,
        placesSuggestions,
        isSearchResultVisible,
        errorMsg,
      ];

  MapsState copyWith({
    List<Marker>? markers,
    List<Suggestion>? placesSuggestions,
    bool? isSearchResultVisible,
    String? errorMsg,
    int? selectedMarkerIndex,
    Directions? directions,
  }) {
    return MapsState(
      markers: markers ?? this.markers,
      placesSuggestions: placesSuggestions ?? this.placesSuggestions,
      isSearchResultVisible:
          isSearchResultVisible ?? this.isSearchResultVisible,
      errorMsg: errorMsg ?? this.errorMsg,
      selectedMarkerIndex: selectedMarkerIndex ?? this.selectedMarkerIndex,
      directions: directions ?? this.directions,
    );
  }

  factory MapsState.initial() {
    return const MapsState(
      markers: [],
      placesSuggestions: [],
      isSearchResultVisible: false,
      errorMsg: '',
    );
  }
}
