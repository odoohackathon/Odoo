// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../constants/app_colors.dart';
//
// class BorderedTextField extends StatelessWidget {
//   final TextEditingController controller;
//   String? hintText;
//   Widget? prefixIcon;
//   Widget? suffixIcon;
//   bool? obscureText;
//   EdgeInsetsGeometry? padding;
//   FormFieldValidator<String>? validator;
//   TextInputType? keyboardType;
//   bool? readOnly;
//   ValueChanged<String>? onChanged;
//   double? suffixIconWidth;
//   double? prefixIconWidth;
//   double? suffixIconHeight;
//   double? prefixIconHeight;
//   int? maxLines;
//   int? maxLength;
//   Widget? Function(BuildContext, {required int currentLength, required bool isFocused, required int? maxLength})? buildCounter;
//
//   BorderedTextField({
//     required this.controller,
//     this.hintText,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.obscureText=false,
//     this.padding,
//     this.validator,
//     this.keyboardType,
//     this.readOnly,
//     this.onChanged,
//     this.suffixIconWidth=35,
//     this.prefixIconWidth=35,
//     this.suffixIconHeight=30,
//     this.prefixIconHeight=30,
//     this.maxLines=1,
//     this.maxLength,
//     this.buildCounter,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: padding ?? EdgeInsets.zero,
//       child: TextFormField(
//         maxLength: maxLength,
//         textInputAction: TextInputAction.next,
//         maxLines: maxLines,
//         readOnly: readOnly ?? false,
//         keyboardType: keyboardType ?? TextInputType.text,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         obscureText: obscureText!,
//         controller: controller,
//         cursorHeight: 20.h,
//         validator: validator,
//         onChanged: onChanged,
//         buildCounter: buildCounter,
//         style: textFieldTextStyle,
//         decoration: InputDecoration(
//           errorMaxLines: 2,
//           errorStyle: TextStyle(height: 1.2),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: AppColors.shade400GreyColor, width: 1)),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: AppColors.redColor, width: 1)),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: AppColors.redColor, width: 1)),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: Colors.black, width: 1)),
//           suffixIcon: suffixIcon,
//           prefixIcon: prefixIcon,
//           isCollapsed: true,
//           contentPadding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 15.w),
//           hintText: hintText,
//           hintStyle: textFieldHintText,
//           suffixIconConstraints:  BoxConstraints.tight(Size(suffixIconWidth!, suffixIconHeight!)),
//           prefixIconConstraints:  BoxConstraints.tight(Size(prefixIconWidth!, prefixIconHeight!)),
//         ),
//       ),
//     );
//   }
// }
