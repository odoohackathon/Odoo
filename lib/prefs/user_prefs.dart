import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences
{

  static Future<void> setUser({required String userType, required String token}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isLogin", true);
    preferences.setString("userType", userType);
    preferences.setString("token", token);
  }


  Future<String> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user = preferences.getString("userType") ?? "No User";
    return user;
  }

  static Future<void> removeUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("isLogin");
    preferences.remove("userType");
    preferences.remove("token");
  }

  // static Future<void> setUserDeviceToken({required String deviceToken}) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString(Strings.deviceTokenKey, deviceToken);
  // }

}
