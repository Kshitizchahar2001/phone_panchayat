// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/sharedPreferenceService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _selectedTheme;
  SharedPreferences prefs;

  ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: maroonColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    primaryIconTheme: IconThemeData(
      color: Colors.white,
    ),
    colorScheme:
        ColorScheme.dark(background: Color(0xff000000), primary: maroonColor),
    textSelectionTheme: TextSelectionThemeData(cursorColor: KThemeLightGrey),
    brightness: Brightness.dark,
    accentColor: maroonColor,
    scaffoldBackgroundColor: cardBackgroundDark,
    shadowColor: Colors.transparent,
    cardColor: Color(0xff000000),
    inputDecorationTheme: InputDecorationTheme(fillColor: Color(0xff333333)),
    textTheme: TextTheme(
      subtitle2: TextStyle(color: lightBlueBrightColor),
      headline1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
      ),
      headline3: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
      headline4: TextStyle(
        color: Colors.grey[500],
      ),
      headline5: TextStyle(
        color: Color(0xffFAFAFA),
      ),
      headline6: TextStyle(
        color: Color(0xffFAFAFA),
      ),
      subtitle1: TextStyle(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xff272727),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      // color: Color(0xff1F1F1F),
    ),
    toggleableActiveColor: maroonColor,
  );

  ThemeData light = ThemeData.light().copyWith(
    primaryColor: maroonColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    primaryIconTheme: IconThemeData(
      color: Colors.black,
    ),
    brightness: Brightness.light,
    textSelectionTheme: TextSelectionThemeData(cursorColor: KThemeLightGrey),
    colorScheme:
        ColorScheme.light(background: Colors.white, primary: maroonColor),
    accentColor: maroonColor,
    indicatorColor: maroonColor,
    shadowColor: Colors.grey[400],
    scaffoldBackgroundColor: Colors.grey[100],
    // scaffoldBackgroundColor: Color(0xffE6E6E6),
    cardColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Color(0xffE0E0E0),
    ),
    textTheme: TextTheme(
      subtitle2: TextStyle(color: KThemeDarkGrey),
      headline1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      headline2: TextStyle(
        color: KThemeDarkGrey,
        fontWeight: FontWeight.normal,
      ),
      headline3:
          TextStyle(color: KThemeLightGrey, fontWeight: FontWeight.normal),
      headline4: TextStyle(
        color: Color(0xff5C5C5C),
      ),
      headline5: TextStyle(
        color: Color(0xff5C5C5C),
      ),
      headline6: TextStyle(color: Colors.black),
      subtitle1: TextStyle(
        color: Colors.grey[800],
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xffFCFCFC),
      selectedItemColor: maroonColor,
      unselectedItemColor: Colors.grey[600],
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      // color: Color(0xffFCFCFC),
    ),
    toggleableActiveColor: maroonColor,
  );

  ThemeProvider(bool darkThemeOn) {
    _selectedTheme = darkThemeOn ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> swapTheme() async {
    prefs = SharedPreferenceService.sharedPreferences;

    if (_selectedTheme == ThemeMode.dark) {
      _selectedTheme = ThemeMode.light;
      await prefs.setBool("darkTheme", false);
    } else {
      _selectedTheme = ThemeMode.dark;
      await prefs.setBool("darkTheme", true);
    }

    notifyListeners();
  }

  notifyThemeProviderListeners() => notifyListeners();

  bool get isDarkModeEnabled => _selectedTheme == ThemeMode.dark;

  ThemeMode get getThemeMode => _selectedTheme;
}
