import 'dart:convert';

import 'package:get/get.dart';
import 'package:oddo/constants.dart';
import 'package:oddo/constants/app_urls.dart';
import 'package:oddo/data/network/network_api_services.dart';
import 'package:oddo/prefs/user_prefs.dart';
import 'package:oddo/res/routes/route_names.dart';

import '../../constants/strings.dart';

class LoginController extends GetxController
{

  RxBool isLoading = false.obs;

  RxString selectedUserType = "${authList[0]}".obs;

  void checkUserExistenceApi(String credential) {
    isLoading.value=true;
    NetworkApiServices().postApi("${AppUrls.baseUrl}${AppUrls.checkExistance}", jsonEncode({
      "userType": selectedUserType.value,
      "credentials": credential
    })).then((value) {
      isLoading.value=false;
      if(value.containsKey(Strings.noInternetKey))
        {
          Get.toNamed(RoutesName.internetExceptionWidget);
        }
      else{
        if(value['result']==false)
          {
            if(selectedUserType.value == authList[0])
              {
                Get.to(RoutesName.userRegistrationScreen);
              }
            else
              {
                Get.to(RoutesName.policeRegistrationScreen);
              }
          }
        else
          {
            UserPreferences.setUser(userType: selectedUserType.value, token: value["token"]);
            if(selectedUserType.value == authList[0])
            {
              Get.to(RoutesName.userHomeScreen);
            }
            else
            {
              Get.to(RoutesName.policeHomeScreen);
            }
          }
      }
    },);
  }

}