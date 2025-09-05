import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static const String _firstRunKey = 'first_run';

  static Future<bool> isFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstRunKey) ?? true;
  }

  static Future<void> setFirstRunDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstRunKey, false);
  }
}
