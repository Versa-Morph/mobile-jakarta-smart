part of 'home_navigation_cubit.dart';

@immutable
sealed class HomeNavigationState {
  final int tabIndex;

  const HomeNavigationState({required this.tabIndex});
}

final class HomeNavigationInitial extends HomeNavigationState {
  const HomeNavigationInitial({required super.tabIndex});
}
