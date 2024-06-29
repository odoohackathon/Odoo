// import 'package:get/get.dart';
// import '../../prefs/user_prefs.dart';
// import '../../res/routes/route_names.dart';
//
// class SplashServices
// {
//
//   static void isLogin(){
//     Future.delayed(Duration(seconds: 3), () {
//       UserPreferences.getUser().then((value)
//       {
//         if(value.containsKey("isJustInstalled"))
//           {
//             Get.offAllNamed(RoutesName.onboardingScreen);
//           }
//         else
//           {
//             if(value.isNotEmpty)
//             {
//               Get.offAllNamed(RoutesName.bottomNavBarScreen);
//             }
//             else
//             {
//               Get.offAllNamed(RoutesName.signUpLoginScreen);
//             }
//           }
//       }
//       );
//
//     });
//   }
//
//
// }