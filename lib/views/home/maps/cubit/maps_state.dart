part of 'maps_cubit.dart';

class MapsState extends Equatable {
  const MapsState({
    required this.markers,
    required this.placesSuggestions,
    required this.isSearchResultVisible,
    required this.errorMsg,
    this.directions,
  });

  final List<Marker> markers;
  final List<Suggestion> placesSuggestions;
  final bool isSearchResultVisible;
  final String errorMsg;
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
    Directions? directions,
  }) {
    return MapsState(
      markers: markers ?? this.markers,
      placesSuggestions: placesSuggestions ?? this.placesSuggestions,
      isSearchResultVisible:
          isSearchResultVisible ?? this.isSearchResultVisible,
      errorMsg: errorMsg ?? this.errorMsg,
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
