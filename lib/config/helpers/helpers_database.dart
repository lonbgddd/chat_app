import 'package:shared_preferences/shared_preferences.dart';

class HelpersFunctions {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserIdKey = "IDKEY";

  static Future<bool> saveUserNameSharedPreference(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future saveIdUserSharedPreference(String uid) async {
    SharedPreferences rs = await SharedPreferences.getInstance();
    return await rs.setString(sharedPreferenceUserIdKey, uid);
  }

  Future<String?> getUserIdUserSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserIdKey).toString();
  }
}
