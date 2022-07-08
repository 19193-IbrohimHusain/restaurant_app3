import 'package:flutter/material.dart';
import '../utils/helper/background/preferences.dart';
import '../utils/resource/style.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyNotificationPreferences();
    _getTheme();
  }

  bool _isDailyNotificationActive = false;
  bool get isDailyNotificationActive => _isDailyNotificationActive;

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeData get themeData => _isDarkMode ? darkMode : lightMode;

  void _getDailyNotificationPreferences() async {
    _isDailyNotificationActive =
        await preferencesHelper.isDailyNotificationActive;
    notifyListeners();
  }

  void _getTheme() async {
    _isDarkMode = await preferencesHelper.isDarkMode;
    notifyListeners();
  }

  void enableDailyNotification(bool value) {
    preferencesHelper.setDailyNotification(value);
    _getDailyNotificationPreferences();
  }

  void enableDarkMode(bool value) {
    preferencesHelper.setDarkMode(value);
    _getTheme();
  }
}
