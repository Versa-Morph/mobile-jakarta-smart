part of 'maps_cubit.dart';

class MapsState extends Equatable {
  const MapsState({
    required this.markers,
    required this.placesSuggestions,
    required this.isSearchResultVisible,
    required this.errorMsg,
    required this.markerIndex,
    this.directions,
  });

  final List<Marker> markers;
  final List<Suggestion> placesSuggestions;
  final bool isSearchResultVisible;
  final String errorMsg;
  final int markerIndex;
  final Directions? directions;

  @override
  List<Object?> get props => [
        markers,
        placesSuggestions,
        isSearchResultVisible,
        errorMsg,
        markerIndex,
        directions,
      ];

  MapsState copyWith({
    List<Marker>? markers,
    List<Suggestion>? placesSuggestions,
    bool? isSearchResultVisible,
    String? errorMsg,
    int? markerIndex,
    Directions? Function()? directions,
  }) {
    return MapsState(
      markers: markers ?? this.markers,
      placesSuggestions: placesSuggestions ?? this.placesSuggestions,
      isSearchResultVisible:
          isSearchResultVisible ?? this.isSearchResultVisible,
      errorMsg: errorMsg ?? this.errorMsg,
      markerIndex: markerIndex ?? this.markerIndex,
      directions: directions != null ? directions() : this.directions,
    );
  }

  factory MapsState.initial() {
    return const MapsState(
      markers: [],
      placesSuggestions: [],
      isSearchResultVisible: false,
      errorMsg: '',
      markerIndex: 0,
    );
  }
}
