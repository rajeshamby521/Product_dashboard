import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  static const TOKEN = "token";

  static final SharedPreferenceUtil _instance =
      SharedPreferenceUtil._internal();

  SharedPreferenceUtil._internal();

  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //This is what's used to retrieve the instance through the app
  static SharedPreferenceUtil getInstance() {
    return _instance;
  }

  Future<bool> getBool(String key) async {
    final SharedPreferences preference = await _prefs;
    return preference.getBool(key) ?? false;
  }

  Future<void> setBool(String key, bool value) async {
    final SharedPreferences preference = await _prefs;
    await preference.setBool(key, value);
  }

  Future<String?> getString(String key) async {
    final SharedPreferences preference = await _prefs;
    return preference.getString(key);
  }

  Future<void> setString(String key, String? value) async {
    final SharedPreferences preference = await _prefs;
    if (value != null) {
      await preference.setString(key, value);
    }
  }

  Future<int?> getInt(String key) async {
    final SharedPreferences preference = await _prefs;
    return preference.getInt(key);
  }

  Future<void> setInt(String key, int? value) async {
    final SharedPreferences preference = await _prefs;
    await preference.setString(key, value.toString());
  }
}
