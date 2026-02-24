import 'package:shared_preferences/shared_preferences.dart';

class PreferenesManger {
  static final PreferenesManger _instance = PreferenesManger._internal();
  factory PreferenesManger() => _instance;
  PreferenesManger._internal();

  SharedPreferences? _preferences;

  Future<void> init() async {
    if (_preferences != null) return;
    _preferences = await SharedPreferences.getInstance();
  }

  // تصحيح: استخدام ? بدلاً من ! لمنع الانهيار (Null Check Error)
  String getString(String key) => _preferences?.getString(key) ?? '';
  
  bool? getBool(String key) => _preferences?.getBool(key);

  Future<bool> setString(String key, String value) async {
    if (_preferences == null) await init();
    return await _preferences!.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    if (_preferences == null) await init();
    return await _preferences!.setBool(key, value);
  }

  Future<void> remove(String key) async {
    if (_preferences == null) await init();
    await _preferences!.remove(key);
  }
}
