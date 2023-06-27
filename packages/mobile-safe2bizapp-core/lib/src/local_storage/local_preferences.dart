import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferences {
  static final LocalPreferences _singleton = LocalPreferences._internal();

  factory LocalPreferences() {
    return _singleton;
  }

  LocalPreferences._internal();

  static SharedPreferences? _prefs;
  void initPrefs() async => _prefs = await SharedPreferences.getInstance();

  static SharedPreferences? get prefs => _prefs;
}
