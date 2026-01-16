import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final SharedPreferencesProvider = Provider.autoDispose<SharedPreferences>((ref) {
  throw UnimplementedError("Initialize SharedPreferences in main.dart");
});

final UserSessionServiceProvider = Provider<UserSessionService>((ref) {
  return UserSessionService(prefs: ref.read(SharedPreferencesProvider));
});

class UserSessionService {
  final SharedPreferences _prefs;

  UserSessionService({required SharedPreferences prefs}) : _prefs = prefs;

  // Keys
  static const String _keyIsLoggedIn = 'is_logged';
  static const String _keyUserId = 'user_id';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUsername = 'username';
  static const String _keyUserFullName = 'user_full_name';
  static const String _keyUserPhoneNumber = 'user_phone_number';
  static const String _keyUserProfileImage = 'user_profile_image';
  static const String _keyToken = 'auth_token';

  // Save session
  Future<void> saveUserSession({
    required String userId,
    required String email,
    required String username,
    required String fullName,
    String? phoneNumber,
    String? profilePicture,
    String? token,
  }) async {
    await _prefs.setBool(_keyIsLoggedIn, true);
    await _prefs.setString(_keyUserId, userId);
    await _prefs.setString(_keyUserEmail, email);
    await _prefs.setString(_keyUsername, username);
    await _prefs.setString(_keyUserFullName, fullName);

    if (phoneNumber != null) await _prefs.setString(_keyUserPhoneNumber, phoneNumber);
    if (profilePicture != null) await _prefs.setString(_keyUserProfileImage, profilePicture);
    if (token != null) await _prefs.setString(_keyToken, token);
  }

  // Clear session
  Future<void> clearUserSession() async {
    await _prefs.remove(_keyIsLoggedIn);
    await _prefs.remove(_keyUserId);
    await _prefs.remove(_keyUserEmail);
    await _prefs.remove(_keyUsername);
    await _prefs.remove(_keyUserFullName);
    await _prefs.remove(_keyUserPhoneNumber);
    await _prefs.remove(_keyUserProfileImage);
    await _prefs.remove(_keyToken);
  }

  // Getters
  bool isLoggedIn() => _prefs.getBool(_keyIsLoggedIn) ?? false;
  String? getUserId() => _prefs.getString(_keyUserId);
  String? getUserEmail() => _prefs.getString(_keyUserEmail);
  String? getUsername() => _prefs.getString(_keyUsername);
  String? getUserFullName() => _prefs.getString(_keyUserFullName);
  String? getUserPhoneNumber() => _prefs.getString(_keyUserPhoneNumber);
  String? getUserProfileImage() => _prefs.getString(_keyUserProfileImage);
  String? getToken() => _prefs.getString(_keyToken);
}
