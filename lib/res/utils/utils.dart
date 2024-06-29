import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oddo/constants/textstyles.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';

Future<DateTime?> showCustomDatePicker ({required BuildContext context}){
  return showDatePicker(
    context: context,
    firstDate: DateTime(2024),
    lastDate: DateTime.now(),
  );
}

Widget addVerticalSpace({required double height}){
  return SizedBox(height: height,);
}

Widget addHorizontalSpace({required double width}){
  return SizedBox(width: width,);
}

void showSnackBar({required String message ,required BuildContext context}){
  Flushbar(
    animationDuration: const Duration(milliseconds: 400),
    forwardAnimationCurve: Curves.easeIn,
    reverseAnimationCurve: Curves.easeOut,
    duration: const Duration(seconds: 2),
    borderRadius: BorderRadius.circular(10.w),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    isDismissible: true,
    flushbarPosition: FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.FLOATING,
    message: message,
    margin: EdgeInsets.all(20.w),
  ).show(context);
}

Widget titleWithDescription ({required String title,String? desc}){
  return Column(
    children: [
      Text(
        title,
        style: black18w600,
      ),
      Text(
        desc ?? "",
        style: grey15Shade400,
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget primaryAppLogoWidget(){
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 15.h),
    child: Image.asset(AppImages.appLogo, height: 180.h, width: 180.w,),
  );
}

bool validateEmail(String value) {
  if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return true;
  } else {
    return false;
  }
}

PreferredSizeWidget primaryLogoAppBar({List<Widget>? actions}) {
  return AppBar(
      surfaceTintColor: AppColors.primaryAppColor,
      elevation: 7,
      shadowColor: AppColors.shade400GreyColor,
      toolbarHeight: 55.h,
      leadingWidth: 50.w,
      backgroundColor: AppColors.primaryAppColor,
      title: SizedBox(child: Image.asset(AppImages.appLogoWhite, height: 40.h,)),
      actions: actions
  );
}

PreferredSizeWidget primaryTextAppBar({required String title}){
  return AppBar(
    surfaceTintColor: AppColors.primaryAppColor,
    elevation: 7,
    shadowColor: AppColors.shade400GreyColor,
    toolbarHeight: 55.h,
    leadingWidth: 35.w,
    leading: Icon(Icons.arrow_back, color: AppColors.whiteColor,),
    backgroundColor: AppColors.primaryAppColor,
    title: Text(title, style: appbarTitleStyle),
  );
}

Widget imagePickContainer(String filePath, Function() ontap) {
  return Padding(
    padding: EdgeInsets.only(right: 6.6.w),
    child: InkWell(
      onTap: ontap,
      child: Container(
        height: 150.h,
        width: 150.w,
        decoration: BoxDecoration(
            image: filePath != ""
                ? DecorationImage(
                fit: BoxFit.cover, image: FileImage(File(filePath)))
                : null,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)),
        child: filePath == ""
            ? Icon(Icons.add_photo_alternate_outlined,
            color: AppColors.shade400GreyColor, size: 35.w)
            : null,
      ),
    ),
  );
}
Widget videoPickContainer(String filePath, Function() ontap) {
  return Padding(
    padding: EdgeInsets.only(right: 6.6.w),
    child: InkWell(
      onTap: ontap,
      child: Container(
        height: 50.h,
        width: 150.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)),
        child: filePath == ""
            ? Center(child: Icon(Icons.video_call, color: AppColors.shade400GreyColor,),)
            : Center(child: Text("Video Selected")),
      ),
    ),
  );
}

Widget centerLoadingWidget(){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
    decoration: BoxDecoration(
        color: Colors.black54.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15)
    ),
    child: CircularProgressIndicator(color: Colors.white,),
  );
}
Future<User?> signInWithGoogle() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  try {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // The user canceled the sign-in
      return null;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  } catch (e) {
    print(e);
    return null;
  }
}