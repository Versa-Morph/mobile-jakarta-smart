import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xfffafafa),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xfffafafa),
    ),
    colorScheme: const ColorScheme.light(),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xff2C3539),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff2C3539),
    ),
    colorScheme: const ColorScheme.dark(),
  );
}
