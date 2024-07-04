part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  const HomePageState({
    required this.tabIndex,
  });
  final int tabIndex;

  HomePageState copyWith({
    int? tabIndex,
  }) {
    return HomePageState(
      tabIndex: tabIndex ?? this.tabIndex,
    );
  }

  factory HomePageState.initial() {
    return const HomePageState(
      tabIndex: 0,
    );
  }

  @override
  List<Object?> get props => [tabIndex];
}
