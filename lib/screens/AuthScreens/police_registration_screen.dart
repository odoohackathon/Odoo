import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oddo/constants/contantData.dart';
import 'package:oddo/res/utils/utils.dart';
import 'package:oddo/view_modals/controllers/registration_controller.dart';
import 'package:oddo/widgets/bordered_textfield_with_title.dart';
import 'package:oddo/widgets/primary_button.dart';

class PoliceRegistrationScreen extends StatelessWidget {
  final controller = Get.put(RegistrationController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ConstantData.defaultPadding),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  primaryAppLogoWidget(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: titleWithDescription(title: "Registration", desc: "Give Additional Data to verify\nyou better"),
                  ),
                  BorderedTextFieldWithTitle(
                    controller: controller.emailController.value,
                    title: "Enter Email",
                    hintText: "Enter Email",
                    validator: (value) {
                      if(value!.isEmpty)
                      {
                        return "Please enter email";
                      }
                      else if(!validateEmail(value))
                      {
                        return "Please enter valid email";
                      }
                      else
                      {
                        return null;
                      }
                    },
                  ),
                  BorderedTextFieldWithTitle(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    controller: controller.mnoController.value,
                    title: "Enter Mobile Number",
                    hintText: "Enter Mobile Number",
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    validator: (value) {
                      if(value!.isEmpty)
                      {
                        return "Please enter mobile number";
                      }
                      else if(value.length!=10)
                      {
                        return "Must contain 10 digit";
                      }
                      else
                      {
                        return null;
                      }
                    },
                  ),
                  BorderedTextFieldWithTitle(
                    controller: controller.nameController.value,
                    title: "Enter Name",
                    hintText: "Enter name",
                    validator: (value) {
                      if(value!.isEmpty)
                      {
                        return "Please enter name";
                      }
                      else
                      {
                        return null;
                      }
                    },
                  ),
                  BorderedTextFieldWithTitle(
                    controller: controller.nameController.value,
                    title: "Enter Your Police ID Number",
                    hintText: "Enter ID Number",
                    validator: (value) {
                      if(value!.isEmpty)
                      {
                        return "Please enter name";
                      }
                      else if(! RegExp(r'^[A-Z]{2}-\d{6}$').hasMatch(value))
                        {
                          return "Invalid Police ID Number";
                        }
                      else
                      {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25.h),
                    child: PrimaryButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate())
                          {

                          }
                        else{

                        }
                      },
                      text: "Register",
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
