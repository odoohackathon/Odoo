import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oddo/constants/contantData.dart';
import 'package:oddo/constants/strings.dart';
import 'package:oddo/res/routes/route_names.dart';
import 'package:oddo/res/utils/utils.dart';
import 'package:oddo/view_modals/controllers/UserControllers/add_crime_controller.dart';
import 'package:oddo/widgets/bordered_textfield_with_title.dart';
import 'package:oddo/widgets/primary_button.dart';
import 'package:http/http.dart' as http;

import '../../../constants/textstyles.dart';

class AddCrimeReportScreen extends StatelessWidget {
  final controller = Get.put(AddCrimeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: primaryTextAppBar(title: Strings.addCrime),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ConstantData.defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                ()=> Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: CheckboxListTile(
                    title: Text("Reveal your name"),
                    value: controller.isAnonymous.value, onChanged: (value) {
                      controller.isAnonymous.value=value!;
                  },),
                ),
              ),
              BorderedTextFieldWithTitle(
                controller: controller.descriptionController.value,
                title: "Enter Description",
                hintText: "Enter Description",
                maxLines: 5,
                padding: EdgeInsets.only(bottom: 20.h),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Image : ", style: black15w500,),
                  Obx(
                        ()=> imagePickContainer(controller.selectedImage.value, () async {
                      XFile? file =
                      await ImagePicker().pickImage(source: ImageSource.gallery);
                      if(file!=null)
                      {
                        controller.selectedImage.value = file.path;
                      }
                    },),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select Video : ", style: black15w500,),
                    Obx(
                          ()=> videoPickContainer(controller.selectedVideo.value, () async {
                        XFile? file =
                        await ImagePicker().pickVideo(source: ImageSource.gallery);
                        if(file!=null)
                        {
                          controller.selectedVideo.value = file.path;
                        }
                      },),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(" Select Crime Location : ", style: black15w500,),
                  Obx(
                        ()=> videoPickContainer(controller.latLngValue.value.latitude.toString(), () async {
                          Get.toNamed(RoutesName.mapScreen);
                    },),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: PrimaryButton(
                  text: "Add Crime",
                  onPressed: () {
          
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
