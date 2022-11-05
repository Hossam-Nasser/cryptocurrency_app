import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;


  Future<void> saveThemeModeToSharedPref(ThemeMode mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String themeMode = "System";
    switch (mode) {
      case ThemeMode.system:
        this.themeMode = ThemeMode.system;
        themeMode = "System";
        break;
      case ThemeMode.dark:
        this.themeMode = ThemeMode.dark;
        themeMode = "Dark";
        break;
      case ThemeMode.light:
        this.themeMode = ThemeMode.light;
        themeMode = "Light";
        break;
    }
    notifyListeners();
    prefs.setString("themeMode", themeMode);
  }


  void getThemeModeFromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeModeString = prefs.getString("themeMode");
    if (themeModeString == "System") {
      themeMode = ThemeMode.system;
    } else if (themeModeString == "Light") {
      themeMode = ThemeMode.light;
    } else if (themeModeString == "Dark") {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.system;
    }
    notifyListeners();
  }


}