import 'package:shared_preferences/shared_preferences.dart';

class HelpersFunctions {
  static String sharedPreferenceUserIdKey = "IDKEY";

  static String sharedPreferenceNameUserKey = "NAMEKEY";
  static String sharedPreferenceAvatarUserKey = "AVATARKEY";
  static String sharedPreferenceTokenKey = "TOKENKEY";

  static Future saveTokenUserSharedPreference(String token) async {
    SharedPreferences rs = await SharedPreferences.getInstance();
    return await rs.setString(sharedPreferenceTokenKey, token);
  }

  Future<String?> getUserTokenSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceTokenKey).toString();
  }


  static Future saveIdUserSharedPreference(String uid) async {
    SharedPreferences rs = await SharedPreferences.getInstance();
    return await rs.setString(sharedPreferenceUserIdKey, uid);
  }

  Future<String?> getUserIdUserSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserIdKey).toString();
  }

  Future<String?> getNameUserSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceNameUserKey).toString();
  }

  Future<String?> getAvatarUserSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceAvatarUserKey).toString();
  }

  static Future saveNameUserSharedPreference(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceNameUserKey, name);
  }

  static Future saveAvatarUserSharedPreference(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceAvatarUserKey, name);
  }
}
