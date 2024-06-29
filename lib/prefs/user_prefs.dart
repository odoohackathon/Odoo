// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserPreferences
// {
//
//   static Future<void> setUser({required Map map}) async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     preferences.setBool("isLogin", true);
//     preferences.setString("data", jsonEncode(map));
//   }
//
//   static Future<Map> getUser() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     bool isJustInstalled = preferences.getBool("isJustInstalled") ?? false;
//     bool isLogin = preferences.getBool("isLogin") ?? false;
//     if(!isJustInstalled)
//       {
//         return {"isJustInstalled": true};
//       }
//     else
//       {
//         if(isLogin)
//         {
//           Map map = jsonDecode(preferences.getString("data") ?? "");
//           return map;
//         }
//         else{
//           return {};
//         }
//       }
//   }
//
//   static Future<void> removeUser() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     preferences.remove("isLogin");
//     preferences.remove("data");
//   }
//
//   static Future<void> setOnBoardingFalse() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     preferences.setBool("isJustInstalled", true);
//   }
//
//   static Future<void> setUserDeviceToken({required String deviceToken}) async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     preferences.setString(Strings.deviceTokenKey, deviceToken);
//   }
//
// }
