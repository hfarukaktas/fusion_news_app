import 'package:flutter/material.dart';
import 'package:fusion_news_app/core/theme/app_palette.dart';

class AppTheme {
  static UnderlineInputBorder _border(Color color) {
    return UnderlineInputBorder(borderSide: BorderSide(color: color));
  }

  static final darkThemeMode = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(14),
      focusedBorder: _border(Pallete.onBackgroundColor),
      enabledBorder: _border(Pallete.white),
    ),
  );

  static final lightThemeMode = ThemeData(
    appBarTheme: AppBarTheme(backgroundColor: Pallete.white),
    tabBarTheme: TabBarTheme(
      labelColor: Pallete.backgroundColor,
      unselectedLabelColor: Colors.grey,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Pallete.backgroundColor, width: 3),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Pallete.white,
      selectedIconTheme: IconThemeData(
        color: Pallete.backgroundColor,
        size: 30,
      ),
      unselectedIconTheme: IconThemeData(color: Colors.grey, size: 30),
    ),
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: Pallete.white,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(14),
      focusedBorder: _border(Pallete.onBackgroundColor),
      enabledBorder: _border(Pallete.white),
    ),
    listTileTheme: ListTileThemeData(
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      visualDensity: VisualDensity.compact,
    ),
  );
}
