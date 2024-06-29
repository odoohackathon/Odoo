import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController
{

  final args = Get.arguments;
  RxBool isMailEntered = false.obs;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   isMailEntered = args['isMailEntered'];
  // }

  final emailController = TextEditingController().obs;
  final mnoController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final policeIdController = TextEditingController().obs;

}