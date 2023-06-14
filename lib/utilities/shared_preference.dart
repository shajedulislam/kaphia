import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // create() {
  //   _prefs = SharedPreferences.getInstance();
  // }

  Future setString({required String key, required String value}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
  }

  Future setInt({required String key, required int value}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(key, value);
  }

  Future setBool({required String key, required bool value}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(key, value);
  }

  Future<String?> getString({required String key}) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  Future<int?> getInt({required String key}) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt(key);
  }

  Future<bool?> getBool({required String key}) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(key);
  }

  Future remove({required String key}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(key);
  }

  Future clear() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }
}
