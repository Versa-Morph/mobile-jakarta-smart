part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {
  final ThemeData themeData;
  const ThemeState({required this.themeData});
}

final class ThemeInitial extends ThemeState {
  const ThemeInitial({required super.themeData});
}
