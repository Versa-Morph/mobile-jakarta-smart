part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  const HomePageState({
    required this.tabIndex,
    required this.markers,
    required this.placesSuggestions,
    required this.isSearchResultVisible,
  });
  final int tabIndex;
  final List<Marker> markers;
  final List<Suggestion> placesSuggestions;
  final bool isSearchResultVisible;

  HomePageState copyWith({
    int? tabIndex,
    List<Marker>? markers,
    List<Suggestion>? placesSuggestions,
    bool? isSearchResultVisible,
  }) {
    return HomePageState(
      tabIndex: tabIndex ?? this.tabIndex,
      markers: markers ?? this.markers,
      placesSuggestions: placesSuggestions ?? this.placesSuggestions,
      isSearchResultVisible:
          isSearchResultVisible ?? this.isSearchResultVisible,
    );
  }

  factory HomePageState.initial() {
    return const HomePageState(
      tabIndex: 0,
      markers: [],
      placesSuggestions: [],
      isSearchResultVisible: false,
    );
  }

  @override
  List<Object?> get props => [
        tabIndex,
        markers,
        placesSuggestions,
        isSearchResultVisible,
      ];
}
