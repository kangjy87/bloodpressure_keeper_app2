import 'dart:async';
import 'package:bloodpressure_keeper_app/ui/pages/feed/utils/logger_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKey {
  static const CURATOR9_TOKEN = "qurator9_token";
  static const AUTH_TOKEN = "auth_token";
}

class SharedPrefUtil {

  static Future<String?> getString(String key) async {
    SharedPreferences? pref = await SharedPreferences?.getInstance();
    return pref.getString(key);
  }

  static void setString(String key, String value) {
    SharedPreferences.getInstance().then((pref) {
      pref.setString(key, value);
    });
  }

  static Future<int?> getInt(String key) async {
    SharedPreferences? pref = await SharedPreferences?.getInstance();
    return pref.getInt(key);
  }

  static void setInt(String key, int value) {
    SharedPreferences.getInstance().then((pref) {
      pref.setInt(key, value);
    });
  }
  static Future<bool?> getBool(String key) async {
    SharedPreferences? pref = await SharedPreferences?.getInstance();
    return pref.getBool(key);
  }

  static void setBool(String key, bool value) {
    SharedPreferences.getInstance().then((pref) {
      pref.setBool(key, value);
    });
  }
  static void clear() {
    SharedPreferences.getInstance().then((pref) {
      pref.clear();
    });
  }


  //테스트 할때만 호출 및 사용.
  static void forcedClear () {
    SharedPreferences.getInstance().then((pref) {
      pref.clear();
    });
  }

}
