import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  String? text;
  final VoidCallback onPressed;
  Color backgroundColor;
  double? height;
  double? width;
  double? fontSize;
  BorderRadiusGeometry? borderRadius;
  Color? fontColor;
  bool? isLoad;
  bool? isRowChild;
  Widget? childWidget;

  PrimaryButton({
    this.text,
    required this.onPressed,
    this.backgroundColor=AppColors.primaryAppColor,
    this.height,
    this.width,
    this.fontSize,
    this.borderRadius,
    this.fontColor,
    this.isLoad = false,
    this.isRowChild = false,
    this.childWidget
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50.h,
      width: width ?? double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 7,
            padding: EdgeInsets.zero,
            surfaceTintColor: AppColors.primaryAppColor,
            shadowColor: AppColors.shade400GreyColor,
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(10))),
          onPressed: onPressed,
          child: isLoad! ? Center(child: LoadingAnimationWidget.threeArchedCircle(color: Colors.white, size: 35,)) : (isRowChild! ? childWidget : Text(
            text!,
            style: TextStyle(
                fontSize: fontSize ?? 20.sp,
                fontWeight: FontWeight.w500,
                color: fontColor ?? Colors.white
            ),
          ) )),
    );
  }
}
