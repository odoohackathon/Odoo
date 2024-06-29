import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:oddo/constants.dart';
import 'package:oddo/constants/app_colors.dart';
import 'package:oddo/constants/strings.dart';
import 'package:oddo/constants/textstyles.dart';
import 'package:oddo/view_modals/controllers/login_controller.dart';
import 'package:phone_email_auth/phone_email_auth.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../constants/contantData.dart';
import '../../res/utils/utils.dart';
import '../../widgets/signInWithGoogleButton.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  final phoneEmail = PhoneEmail();
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          ()=> ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            opacity: 0.4,
            blur: 0.9,
            color: Colors.black,
            progressIndicator: centerLoadingWidget(),
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: ConstantData.defaultPadding),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    primaryAppLogoWidget(),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 40.h),
                      child: titleWithDescription(
                          title: Strings.authScreenTitle1,
                          desc: Strings.authScreenTitle2),
                    ),
                    ToggleSwitch(
                      minWidth: 149.w,
                      cornerRadius: 40.0,
                      minHeight: 50.h,
                      animationDuration: 2,
                      animate: true,
                      customTextStyles: [
                        TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold)
                      ],
                      activeBgColors: [
                        [AppColors.primaryAppColor],
                        [AppColors.primaryAppColor]
                      ],
                      activeFgColor: AppColors.whiteColor,
                      inactiveBgColor: AppColors.shade400GreyColor,
                      inactiveFgColor: AppColors.whiteColor,
                      initialLabelIndex: 0,
                      totalSwitches: 2,
                      labels: [authList[0], authList[1]],
                      radiusStyle: true,
                      onToggle: (index) {
                        controller.selectedUserType = authList[index!];
                        // controller.selected.value = index!;
                      },
                    ),
                    addVerticalSpace(height: 30.h),
                    PhoneLoginButton(
                      borderRadius: 15,
                      buttonColor: AppColors.primaryAppColor,
                      onSuccess: (String accessToken, String jwtToken) {
                        if (accessToken.isNotEmpty) {
                          PhoneEmail.getUserInfo(
                            accessToken: accessToken,
                            clientId: phoneEmail.clientId,
                            onSuccess: (userData) async {
                              controller.checkUserExistenceApi( userData.phoneNumber!);
                            },
                          );
                        }
                      },
                      onFailure: (p0) {
                        showSnackBar(message: p0, context: context);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: Text("OR", style: grey20Shade400,),
                    ),
                    SignInWithGoogleButton(ontap: () async {
                      signInWithGoogle();
                    },)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

