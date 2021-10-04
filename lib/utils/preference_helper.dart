import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  final Future<SharedPreferences> sharedPreference;
  PreferenceHelper(this.sharedPreference);
  static const TOKEN = 'TOKEN';
  static const EMAIL = 'EMAIL';
  static const ID = "IDUSER";

  Future<String> get token async {
    final prefs = await sharedPreference;
    return prefs.getString(TOKEN) ?? "";
  }

  void setToken(String value) async {
    final prefs = await sharedPreference;
    prefs.setString(TOKEN, value);
  }

  Future<String> get id async {
    final prefs = await sharedPreference;
    return prefs.getString(ID) ?? "";
  }

  void setId(String value) async {
    final prefs = await sharedPreference;
    prefs.setString(ID, value);
  }

  Future<String> get email async {
    final prefs = await sharedPreference;
    return prefs.getString(EMAIL) ?? "";
  }

  void setEmail(String value) async {
    final prefs = await sharedPreference;
    prefs.setString(EMAIL, value);
  }
}
