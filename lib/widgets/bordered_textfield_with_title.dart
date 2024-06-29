import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';
import '../constants/textstyles.dart';
import '../res/utils/utils.dart';

class BorderedTextFieldWithTitle extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  String? hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool? obscureText;
  EdgeInsetsGeometry? padding;
  FormFieldValidator<String>? validator;
  TextInputType? keyboardType;
  bool? readOnly;
  ValueChanged<String>? onChanged;
  double? suffixIconWidth;
  double? prefixIconWidth;
  double? suffixIconHeight;
  double? prefixIconHeight;
  int? maxLines;
  BorderSide? borderSide;
  int? maxLength;

  BorderedTextFieldWithTitle({
    required this.controller,
    required this.title,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText=false,
    this.padding,
    this.validator,
    this.keyboardType,
    this.readOnly,
    this.onChanged,
    this.suffixIconWidth=35,
    this.prefixIconWidth=35,
    this.suffixIconHeight=30,
    this.prefixIconHeight=30,
    this.maxLines=1,
    this.borderSide,
    this.maxLength
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: black15w500,),
          addVerticalSpace(height: 5.h),
          TextFormField(
            textInputAction: TextInputAction.next,
            maxLines: maxLines,
            readOnly: readOnly ?? false,
            keyboardType: keyboardType ?? TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: obscureText!,
            controller: controller,
            cursorHeight: 20.h,
            validator: validator,
            onChanged: onChanged,
            maxLength: maxLength,
            style: black15w500,
            decoration: InputDecoration(
              counterText: "",
              errorMaxLines: 2,
              filled: true,
              fillColor: AppColors.whiteColor,
              errorStyle: TextStyle(height: 0.8),
              enabledBorder: OutlineInputBorder(
                  borderSide: borderSide ?? BorderSide.none,
                  borderRadius: BorderRadius.circular(5)),
              focusedBorder: OutlineInputBorder(
                  borderSide: borderSide ?? BorderSide.none,
                  borderRadius: BorderRadius.circular(5)),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.red, width: 1),
              ),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              isCollapsed: true,
              contentPadding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 15.w),
              hintText: hintText,
              hintStyle: textFieldHintText,
              suffixIconConstraints:  BoxConstraints.tight(Size(suffixIconWidth!, suffixIconHeight!)),
              prefixIconConstraints:  BoxConstraints.tight(Size(prefixIconWidth!, prefixIconHeight!)),
            ),
          ),
        ],
      ),
    );
  }
}
