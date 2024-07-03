import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/theme/app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(
          ThemeInitial(
            themeData: AppTheme.lightTheme,
          ),
        );

  void toggleTheme() {
    if (state.themeData == AppTheme.lightTheme) {
      emit(ThemeInitial(themeData: AppTheme.darkTheme));
    } else {
      emit(ThemeInitial(themeData: AppTheme.lightTheme));
    }
  }
}
