import 'package:flutter/material.dart';

class Themes {

  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.green,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20,
          fontWeight: FontWeight.bold),
      color: Colors.blueGrey[50],
      elevation: 0,
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.blueGrey[50],
  );


  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
        color: Colors.black,
        elevation: 0
    ),
    scaffoldBackgroundColor: Colors.black,


  );


  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }



  }