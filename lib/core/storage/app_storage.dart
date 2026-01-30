import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static String _userKey(String userId) => 'has_logged_in_$userId';

  static Future<void> setLoggedInOnce(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_userKey(userId), true);
  }

  static Future<bool> hasLoggedInOnce(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_userKey(userId)) ?? false;
  }
}
