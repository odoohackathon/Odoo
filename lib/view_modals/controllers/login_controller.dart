import 'dart:convert';

import 'package:get/get.dart';
import 'package:oddo/constants.dart';
import 'package:oddo/constants/app_urls.dart';
import 'package:oddo/data/network/network_api_services.dart';

class LoginController extends GetxController
{

  RxBool isLoading = false.obs;

  RxString selectedUserType = "${authList[0]}".obs;

  void checkUserExistenceApi(){
    NetworkApiServices().postApi("${AppUrls.baseUrl}${AppUrls.checkExistance}", jsonEncode({

    })).then((value) {

    },);
  }

}