import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/const.dart';

class DarkThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  set setDarkTheme(bool value) {
    _isDarkMode = value;
    darkMode(value);
    notifyListeners();
  }

  darkMode(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool("DarkMode", value);
  }

  Future<bool> getDarkTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool("DarkMode") ?? false;
  }
}

class AppTheme {
  static ThemeData myThemes(BuildContext context, bool darktheme) {
    return ThemeData(
      brightness: darktheme ? Brightness.dark : Brightness.light,
      // ignore: deprecated_member_use
      // accentColor: darktheme ? Colors.grey : Colors.teal,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darktheme ? Colors.black : AppColor.lightBackground,
      ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ButtonStyle(
      //   backgroundColor:
      //       MaterialStateProperty.all(darktheme ? Colors.teal : Colors.teal),
      // )),

      appBarTheme: AppBarTheme(
        // color: darktheme ? Colors.black12 : AppColor.lightBackground,
        backgroundColor: darktheme ? Colors.black : AppColor.lightBackground,
        foregroundColor: darktheme ? Colors.white : Colors.black,

        // elevation: darktheme ? 5 : 0.0,
        // color: darktheme ? const Color.fromRGBO(63, 63, 64, 0.2) : Colors.teal,
      ),
      scaffoldBackgroundColor:
          darktheme ? Colors.black : AppColor.lightBackground,
      // iconTheme: IconThemeData(
      //   color: darktheme ? Colors.white : Colors.black,
      // ),
      // primaryColor: darktheme ? Colors.white : Colors.black,

      inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
              color: darktheme ? AppColor.shadeGrey : Colors.black,
              fontFamily: AppFonts.medium)),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: darktheme ? Colors.white : Colors.black,
        ),
        displayMedium: TextStyle(
          color: darktheme ? Colors.white : Colors.black,
        ),
        displaySmall: TextStyle(
          color: darktheme ? Colors.white : Colors.black,
        ),
        headlineMedium: TextStyle(
          color: darktheme ? Colors.white : Colors.black,
        ),
        headlineSmall: TextStyle(
          color: darktheme ? Colors.white : Colors.black,
        ),
        titleLarge: TextStyle(
          color: darktheme ? Colors.white : Colors.black,
        ),
        titleMedium: TextStyle(
          color: darktheme ? Colors.white : Colors.black,
        ),
        titleSmall: TextStyle(
          color: darktheme ? Colors.white : Colors.black,
        ),
        bodyLarge: TextStyle(
          color: darktheme ? Colors.white : Colors.black,
        ),
        bodyMedium: TextStyle(
          color: darktheme ? Colors.white : Colors.black,
        ),
        bodySmall: TextStyle(
          color: darktheme ? Colors.white : Colors.black,
        ),
        labelLarge: TextStyle(
          color: darktheme ? Colors.white : Colors.black,
        ),
        labelSmall: TextStyle(
          color: darktheme ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
