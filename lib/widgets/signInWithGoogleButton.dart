import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oddo/constants/app_icons.dart';
import 'package:oddo/constants/textstyles.dart';

class SignInWithGoogleButton extends StatelessWidget {
  final Function() ontap;

  SignInWithGoogleButton({required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Image.asset(AppIcons.googleLogo),
                height: 28.h,
                width: 28.w,
              ),
              Text("Sign in with google",style: grey12Shade400,)
            ],
          )),
    );
  }
}
