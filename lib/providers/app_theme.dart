import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme extends ChangeNotifier {
  AppTheme() {
    _loadTheme();
  }

  ThemeData _themeData;
  bool _isDark;

  static const Color _lightPrimaryColor = Colors.teal;
  static const Color _lightSecondaryColor = Colors.tealAccent;

  static const Color _darkPrimaryColor = Colors.teal;
  static const Color _darkSecondaryColor = Colors.tealAccent;

  static final ThemeData _lightThemeData = ThemeData.light().copyWith(
    accentColor: _lightPrimaryColor,
    primaryColor: _lightPrimaryColor,
    toggleableActiveColor: _lightPrimaryColor,
    buttonColor: _lightPrimaryColor,
    disabledColor: _lightSecondaryColor,
    accentTextTheme: TextTheme(bodyText1: TextStyle(color: _lightPrimaryColor)),
    sliderTheme: SliderThemeData(
      activeTrackColor: _lightPrimaryColor,
      inactiveTrackColor: _lightSecondaryColor,
      thumbColor: _lightPrimaryColor,
      overlayColor: _lightSecondaryColor,
    ),
  );

  static final ThemeData _darkThemeData = ThemeData.dark().copyWith(
    accentColor: _darkPrimaryColor,
    primaryColor: _darkPrimaryColor,
    toggleableActiveColor: _darkPrimaryColor,
    buttonColor: _darkPrimaryColor,
    disabledColor: _darkSecondaryColor,
    accentTextTheme: TextTheme(bodyText1: TextStyle(color: _darkPrimaryColor)),
    sliderTheme: SliderThemeData(
      activeTrackColor: _darkPrimaryColor,
      inactiveTrackColor: _darkSecondaryColor,
      thumbColor: _darkPrimaryColor,
      overlayColor: _darkSecondaryColor,
    ),
  );

  get lightTheme => _lightThemeData;
  get darkTheme => _darkThemeData;
  get isDark => _isDark;
  get theme => _themeData;

  void updateTheme(bool isDark) async {
    _isDark = isDark;
    (_isDark == true)
        ? _themeData = _darkThemeData
        : _themeData = _lightThemeData;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', _isDark);
    notifyListeners();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDark = (prefs.getBool('isDark')) ?? false;
    updateTheme(_isDark);
  }
}
