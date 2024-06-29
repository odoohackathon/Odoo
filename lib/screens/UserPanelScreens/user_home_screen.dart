import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oddo/constants/contantData.dart';
import 'package:oddo/constants/strings.dart';
import 'package:oddo/res/routes/route_names.dart';
import 'package:oddo/res/utils/utils.dart';
import 'package:oddo/widgets/home_screen_card.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: primaryLogoAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Column(
          children: [
            HomeScreenCards(Strings.addCrime, () {
              Get.toNamed(RoutesName.addCrimeReportScreen);
            },),
            HomeScreenCards(Strings.viewCrimes, () {
              Get.toNamed(RoutesName.viewCrimeReportScreen);
            },),
          ],
        ),
      ),
    );
  }
}
