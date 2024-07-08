part of 'maps_cubit.dart';

class MapsState extends Equatable {
  const MapsState({
    required this.markers,
    required this.placesSuggestions,
    required this.isSearchResultVisible,
    required this.errorMsg,
  });

  final List<Marker> markers;
  final List<Suggestion> placesSuggestions;
  final bool isSearchResultVisible;
  final String errorMsg;

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
  }) {
    return MapsState(
      markers: markers ?? this.markers,
      placesSuggestions: placesSuggestions ?? this.placesSuggestions,
      isSearchResultVisible:
          isSearchResultVisible ?? this.isSearchResultVisible,
      errorMsg: errorMsg ?? this.errorMsg,
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
