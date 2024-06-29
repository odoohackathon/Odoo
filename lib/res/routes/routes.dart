import 'package:get/get.dart';
import 'package:oddo/res/routes/route_names.dart';
import 'package:oddo/screens/AuthScreens/login_screen.dart';
import 'package:oddo/screens/AuthScreens/police_registration_screen.dart';
import 'package:oddo/screens/AuthScreens/user_registration_screen.dart';
import 'package:oddo/screens/PolicePanelScreens/police_home_screen.dart';
import 'package:oddo/screens/UserPanelScreens/AddCrimeReportScreen/add_crime_report_screen.dart';
import 'package:oddo/screens/UserPanelScreens/ViewCrimesReportScreen/view_crime_report_screen.dart';
import 'package:oddo/screens/UserPanelScreens/user_home_screen.dart';
import 'package:oddo/widgets/map_screen.dart';

import '../components/InternetExceptionWidget/internet_exception_widget.dart';

class Routes
{

  static appRoutes () => [

    GetPage(name: RoutesName.internetExceptionWidget, page: () => InternetExceptionWidget(),),
    GetPage(name: RoutesName.loginScreen, page: () => LoginScreen(),),
    GetPage(name: RoutesName.userRegistrationScreen, page: () => UserRegistrationScreen(),),
    GetPage(name: RoutesName.policeRegistrationScreen, page: () => PoliceRegistrationScreen(),),
    GetPage(name: RoutesName.userHomeScreen, page: () => UserHomeScreen(),),
    GetPage(name: RoutesName.policeHomeScreen, page: () => PoliceHomeScreen(),),
    GetPage(name: RoutesName.addCrimeReportScreen, page: () => AddCrimeReportScreen(),),
    GetPage(name: RoutesName.viewCrimeReportScreen, page: () => ViewCrimeReportScreen(),),
    GetPage(name: RoutesName.mapScreen, page: () => MapScreen(),),

  ];

}