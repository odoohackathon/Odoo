import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oddo/res/routes/route_names.dart';
import 'package:oddo/res/utils/utils.dart';

import '../../constants/strings.dart';
import '../../widgets/home_screen_card.dart';

class PoliceHomeScreen extends StatelessWidget {
  const PoliceHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: primaryLogoAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Column(
          children: [
            HomeScreenCards(Strings.checkCrimes, () {
              Get.toNamed(RoutesName.checkReportScreen);
            },),
            HomeScreenCards(Strings.resolveCrime, () {
              Get.toNamed(RoutesName.resolveReportScreen);
            },),
          ],
        ),
      ),
    );
  }
}
