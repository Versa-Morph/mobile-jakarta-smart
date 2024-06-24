import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(
          ThemeInitial(
            themeData: ThemeData.light(),
          ),
        );

  void toggleTheme() {
    if (state.themeData == ThemeData.light()) {
      emit(ThemeInitial(themeData: ThemeData.dark()));
    } else {
      emit(ThemeInitial(themeData: ThemeData.light()));
    }
  }
}
