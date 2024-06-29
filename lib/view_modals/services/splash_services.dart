import 'package:get/get.dart';
import 'package:oddo/constants.dart';
import '../../prefs/user_prefs.dart';
import '../../res/routes/route_names.dart';

class SplashServices
{

  static void isLogin(){
    Future.delayed(Duration(seconds: 3)).then((value) {
      UserPreferences().getUser().then((value) {

        if(value == "No User")
        {
          Get.offAllNamed(RoutesName.loginScreen);
        }
        else if(value == authList[0])
        {
          Get.offAllNamed(RoutesName.userHomeScreen);
        }
        else
        {
          Get.offAllNamed(RoutesName.policeHomeScreen);
        }

      });
    });
  }


}