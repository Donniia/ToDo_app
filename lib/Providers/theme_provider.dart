import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.system;
  SharedPreferences? preferences;
  final String _themeKey = "theme";

  changeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;

    notifyListeners();
    saveTheme(newTheme);
  }

  String? getTheme() {
    return preferences!.getString(_themeKey);
  }
  Future<void> saveTheme(ThemeMode themeMode) async {
    String themeValue = (themeMode == ThemeMode.light ? "light" : "dark");
    await preferences!.setString(_themeKey, themeValue);
  }

  Future<void> loadSettingConfig() async {
    preferences = await SharedPreferences.getInstance();
    String? themeMode = getTheme();
    if (themeMode != null) {
      currentTheme = (themeMode == "light" ? ThemeMode.light : ThemeMode.dark);
    }
  }
}
