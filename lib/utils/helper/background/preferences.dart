import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});
  static const dailyNotification = 'DAILY_NOTIFICATION';
  static const darkMode = 'DARK_MODE';

  Future<bool> get isDailyNotificationActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyNotification) ?? false;
  }

  Future<bool> get isDarkMode async {
    final prefs = await sharedPreferences;
    return prefs.getBool(darkMode) ?? false;
  }

  void setDailyNotification(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyNotification, value);
  }

  void setDarkMode(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(darkMode, value);
  }
}
